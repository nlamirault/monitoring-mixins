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

MIXINS_DIR="mixins"
DOC="README.md"

STARTFLAG="<!-- BEGIN_MIXINS_DOC -->"
ENDFLAG="<!-- END_MIXINS_DOC -->"

function usage() {
    echo "usage: $0"
}

function mixin_version() {
    local mixin=$1
    local tmpfile=$2

    jsonnetfile="${MIXINS_DIR}/${mixin}/jsonnetfile.json"
    if [ ! -f "${jsonnetfile}" ]; then
        echo -e "${KO_COLOR}[monitoring-mixins] Jsonnet not found: ${jsonnetfile} ${NO_COLOR}"
    else
        echo -e "${INFO_COLOR}[monitoring-mixins] ${mixin} ${NO_COLOR}"
        deps=$(jq '.dependencies[] | "\(.source.git.remote) \(.version)"' ${jsonnetfile} | tr '\n' ';')
        IFS=';'
        read -ra data <<< "${deps}"
        echo -n "| ${mixin} | " >> ${tmpfile}
        for i in "${data[@]}"; do
            git=$(echo ${i} | awk -F" " '{ print $1 }')
            version=$(echo ${i} | awk -F" " '{ print $2 }')
            echo -n "${git} - \`${version}\` <br> " >> ${tmpfile}
        done
        echo "|" >> ${tmpfile}
    fi
}

echo -e "${OK_COLOR}[monitoring-mixins] Extract mixins versions ${NO_COLOR}"

tmpfile=$(mktemp)
START=false

while read LINE; do
    echo ">>>>>>>> ${LINE}"

    if [ "${START}" == "true" ]; then
        for mixin in $(ls ${MIXINS_DIR}); do
            mixin_version ${mixin} ${tmpfile}
        done
        break
    elif [ "${LINE}" == "${STARTFLAG}" ]; then
            START="true"
            echo "${STARTFLAG}" >> ${tmpfile}
            continue
    else
        echo "${LINE}" >> ${tmpfile}
    fi
done < ${DOC}

echo "${ENDFLAG}" >> ${tmpfile}
cat ${tmpfile}
mv ${tmpfile} ${DOC}
