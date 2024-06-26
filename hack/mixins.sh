#!/bin/bash

# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euo pipefail

reset_color="\\x1B[0m"
color_red="\\x1B[0;31m"
color_green="\\x1B[0;32m"
color_blue="\\x1B[0;36m";

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}$*${reset_color}"; }

# echo -e "${OK_COLOR}[ Monitoring Mixins ]${NO_COLOR}"

MIXINS_DIR="mixins"

KUBE_LABELS="app: prometheus"

function usage() {
    echo "usage: $0 <output directory> <tenant> <version> [ <mixin> ]"
}

function manifest_rules() {
    local mixin=$1
    local file=$2
    local rules_dir=$3

    k8s_file=$(basename ${file})
    name=$(echo ${k8s_file%%.*} | sed -e "s/_/\-/g")
    rules=$(cat ${file} | sed -e "s/^/  /g")

    # cat ${file}
    # echo "Kubernetes: ${rules_dir}/${k8s_file}"

    cat <<EOF >${rules_dir}/${k8s_file}
---
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: ${mixin}-${name}
  labels:
    ${KUBE_LABELS}
spec:
${rules}
EOF
}

function move_prom_file {
    local prom_file=$1
    local output=$2

    if [[ $(wc -l <${prom_file}) -ge 2 ]]; then
        mv ${prom_file} ${output}
    else
        rm ${prom_file}
    fi
}

function jsonnet_init {
    if [ -f "jsonnetfile.lock.json" ]; then
        jb update
    else
        jb install
    fi
    if [ -f "mixin.tpl.libsonnet" ]; then
        envsubst < "mixin.tpl.libsonnet" > "mixin.libsonnet"
    fi
}

function jsonnet_generate {
    local mixin=$1
    local output=$2

    echo_info "[monitoring-mixins] Mixtool for: ${mixin}"
    mixtool generate all mixin.libsonnet
    mkdir -p ${output}/${mixin}/{prometheus,manifests,dashboards}
    move_prom_file "alerts.yaml" "${output}/${mixin}/prometheus"
    move_prom_file "rules.yaml" "${output}/${mixin}/prometheus"
    find dashboards_out -name '*.json' -print0 | xargs -0 -r -I file mv "file" ${output}/${mixin}/dashboards
    for file in $(find ${output}/${mixin}/prometheus/ -name "*.yaml"); do
        if [[ $(wc -l <${file}) -ge 2 ]]; then
            manifest_rules "${mixin}" ${file} "${output}/${mixin}/manifests"
        fi
    done
}

function mixin_version {
    jsonnetfile=$1
    deps=$(jq '.dependencies[] | "\(.source.git.remote) \(.version)"' ${jsonnetfile} | tr '\n' ';')
    IFS=';'
    read -ra data <<< "${deps}"
    i="${data[${#data[@]}-1]}" # Last dependencies
    git=$(echo ${i} | sed -e 's/"//g' | awk -F" " '{ print $1 }')
    deps_version=$(echo ${i} | sed -e 's/"//g' | awk -F" " '{ print $2 }')
    if [ ${deps_version} == "master" ]; then
        version=${deps_version}
    else
        version=$(echo ${deps_version} | sed -e s/[a-z\-]"//g")
    fi
    echo $version
}

function mixin_build {
    local mixin=$1
    local output=$2

    if [ ! -d "${MIXINS_DIR}/${mixin}" ]; then
        echo_fail "[monitoring-mixins] Not found: ${mixin}"
        exit 1
    fi
    echo_info "[monitoring-mixins] Build: ${mixin}"
    pushd ${MIXINS_DIR}/${mixin} > /dev/null
    mixin_version=$(mixin_version "jsonnetfile.json")
    echo_info "[monitoring-mixins] Mixin version: ${mixin_version}"
    mkdir -p "${output}/${mixin}"
    echo "${mixin_version}" > "${output}/${mixin}/.version"
    jsonnet_init
    jsonnet_generate ${mixin} ${output}
    popd > /dev/null
}

function generate_mixins {
    local output=$1

    echo_info "[monitoring-mixins] Generate all mixins"
    for mixin in $(ls ${MIXINS_DIR}); do
        mixin_build ${mixin} ${output}
    done
}

# echo $#
if [ "$#" -lt 3 ] || [ "$#" -gt 5 ]; then
    usage
    exit 0
fi

output=$(pwd)/$1

export app=$2
export version=$3
echo_info "[monitoring-mixins] Release: ${app}-${version}"

# DEBUG
# jsonnet --version
# jb --version
# mixtool --version

if [ "$#" -eq 4 ]; then
    mixin_build $4 ${output}
else
    generate_mixins ${output}
fi
