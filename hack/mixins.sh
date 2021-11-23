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

OK_COLOR="\e[32m"
KO_COLOR="\e[31m"
NO_COLOR="\e[39m"
INFO_COLOR="\e[36m"

echo -e "${OK_COLOR}[ Monitoring Mixins ]${NO_COLOR}"

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

    mixtool generate all mixin.libsonnet
    mkdir -p ${output}/${mixin}/{prometheus,manifests,dashboards}
    mv alerts.yaml ${output}/${mixin}/prometheus
    mv rules.yaml ${output}/${mixin}/prometheus
    find dashboards_out -name '*.json' -print0 | xargs -0 -r mv -t ${output}/${mixin}/dashboards
    for file in $(ls ${output}/${mixin}/prometheus/*.yaml); do
        # cat ${file}
        if [ ! "{}" = "$(cat ${file})" ]; then
            manifest_rules "${mixin}" ${file} "${output}/${mixin}/manifests"
        fi
    done
}

function monitoring_mixin_mixtool {
    local mixin=$1
    local output=$2

    echo -e "${INFO_COLOR}[monitoring-mixins] Build: ${mixin} ${NO_COLOR}"
    pushd ${MIXINS_DIR}/${mixin} > /dev/null
    jsonnet_init
    jsonnet_generate ${mixin} ${output}
    popd > /dev/null
}

function generate_mixins {
    local output=$1

    echo -e "${OK_COLOR}[monitoring-mixins] Generate all mixins ${NO_COLOR}"
    for mixin in $(ls ${MIXINS_DIR}); do
        monitoring_mixin_mixtool ${mixin} ${output}
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
echo -e "${OK_COLOR}[monitoring-mixins] Generate mixins: ${app}-${version} ${NO_COLOR}"

# DEBUG
# jsonnet --version
# jb --version
# mixtool --version

if [ "$#" -eq 4 ]; then
    monitoring_mixin_mixtool $4 ${output}
else
    generate_mixins ${output}
fi
