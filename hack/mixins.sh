#!/bin/bash

# Copyright (C) 2020-2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

KUBE_LABELS="k8s-app: prometheus
    prometheus: k8s
    role: alert-rules"

function usage() {
    echo "usage: $0 <output directory>"
}

function jsonnet_tools {
    go get github.com/google/go-jsonnet/cmd/jsonnet
    go get github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb
}


function manifest_rules() {
    local mixin=$1
    local file=$2
    local rules_dir=$3

    k8s_file=$(basename ${file})
    name=$(echo ${k8s_file%%.*} | sed -e "s/_/\-/g")
    rules=$(cat ${file} | sed -e "s/^/  /g")

    echo "Kubernetes: ${rules_dir}/${k8s_file}"
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


function monitoring_mixin {
    local mixin=$1
    local output=$2
    local alerts=$3
    local rules=$4
    local dashboards=$5

    echo -e "${INFO_COLOR}[minotor-mixin] Setup Monitoring Mixin: ${mixin} ${NO_COLOR}"
    pushd ${MIXINS_DIR}/${mixin}
    if [ -f "jsonnetfile.lock.json" ]; then
        jb update
    else
        jb install
    fi
    mkdir -p ${output}/${mixin}/{prometheus,manifests,dashboards}
    echo -e "${INFO_COLOR}[minotor-mixin] Generate alerts${NO_COLOR}"
    if [ -n "${alerts}" ]; then
        jsonnet -J vendor -S -e 'std.manifestYamlDoc((import "mixin.libsonnet").prometheusAlerts)' | gojsontoyaml > ${output}/${mixin}/prometheus/alerts.yaml
    fi
    echo -e "${INFO_COLOR}[minotor-mixin] Generate rules${NO_COLOR}"
    if [ -n "${rules}" ]; then
        jsonnet -J vendor -S -e 'std.manifestYamlDoc((import "mixin.libsonnet").prometheusRules)' | gojsontoyaml > ${output}/${mixin}/prometheus/rules.yaml
    fi
    echo -e "${INFO_COLOR}[minotor-mixin] Generate dashboards${NO_COLOR}"
    if [ -n "${dashboards}" ]; then
        jsonnet -J vendor -m ${output}/${mixin}/dashboards -e '(import "mixin.libsonnet").grafanaDashboards'
    fi
    # rm -fr vendor
    echo -e "${INFO_COLOR}[minotor-mixin] Vendorisation${NO_COLOR}"
    for file in $(ls ${output}/${mixin}/prometheus/*.yaml); do
        manifest_rules "${mixin}" ${file} "${output}/${mixin}/manifests"
    done
    popd
}

function monitoring_mixin_mixtool {
    local mixin=$1
    local output=$2

    echo -e "${INFO_COLOR}[minotor-mixin] Setup Monitoring Mixin: ${mixin} ${NO_COLOR}"
    pushd ${MIXINS_DIR}/${mixin}

    mixtool generate all mixin.libsonnet
    mkdir -p ${output}/${mixin}/{prometheus,manifests,dashboards}
    mv alerts.yaml ${output}/${mixin}/prometheus
    mv rules.yaml ${output}/${mixin}/prometheus
    mv dashboards_out/*.json ${output}/${mixin}/dashboards
    for file in $(ls ${output}/${mixin}/prometheus/*.yaml); do
        manifest_rules "${mixin}" ${file} "${output}/${mixin}/manifests"
    done
    popd
}


function alertmanager_mixin {
    local output=$1
    echo -e "${OK_COLOR}[minotor-mixin] Alertmanager Mixin ${NO_COLOR}"
    monitoring_mixin "alertmanager-mixin" ${output} "alerts" "" ""
}

function kube_state_metrics_mixin {
    local output=$1
    echo -e "${OK_COLOR}[minotor-mixin] KubeStateMetrics Mixin ${NO_COLOR}"
    monitoring_mixin "kube-state-metrics-mixin" ${output} "alerts" "" ""
}

function kubernetes_mixin {
    echo -e "${OK_COLOR}[minotor-mixin] Kubernetes Mixin ${NO_COLOR}"
    monitoring_mixin "kubernetes-mixin" ${output} "alerts" "rules" "dashboards"
}

function node_exporter_mixin {
    echo -e "${OK_COLOR}[minotor-mixin] Setup Node Exporter Mixin ${NO_COLOR}"
    monitoring_mixin "node-exporter-mixin" ${output} "alerts" "rules" "dashboards"
}


function prometheus_operator_mixin {
    echo -e "${OK_COLOR}[minotor-mixin] Setup Prometheus Operator Mixin ${NO_COLOR}"
    monitoring_mixin "prometheus-operator-mixin" ${output} "alerts" "" ""
}


function prometheus_mixin {
    echo -e "${OK_COLOR}[minotor-mixin] Setup Prometheus Mixin ${NO_COLOR}"
    monitoring_mixin "prometheus-mixin" ${output} "alerts" "" "dashboards"
}


function thanos_mixin {
    echo -e "${OK_COLOR}[minotor-mixin] Setup Thanos Mixin ${NO_COLOR}"
    monitoring_mixin "thanos-mixin" ${output} "alerts" "rules" "dashboards"
}


function cert_manager_mixin {
    echo -e "${OK_COLOR}[minotor-mixin] Setup Cert Manager Mixin ${NO_COLOR}"
    monitoring_mixin "cert-manager-mixin" ${output} "alerts" "rules" "dashboards"
}

function grafana_mixin {
    echo -e "${OK_COLOR}[minotor-mixin] Setup Grafana Mixin ${NO_COLOR}"
    monitoring_mixin_mixtool "grafana-mixin" ${output}
}

function loki_mixin {
    echo -e "${OK_COLOR}[minotor-mixin] Setup Loki Mixin ${NO_COLOR}"
    monitoring_mixin "loki-mixin" ${output} "alerts" "rules" "dashboards"
}

function promtail_mixin {
    echo -e "${OK_COLOR}[minotor-mixin] Setup Promtail Mixin ${NO_COLOR}"
    monitoring_mixin "promtail-mixin" ${output} "alerts" "rules" "dashboards"
}

function etcd_mixin {
    echo -e "${OK_COLOR}[minotor-mixin] Setup Etcd Mixin ${NO_COLOR}"
    monitoring_mixin "etcd-mixin" ${output} "alerts" "" "dashboards"
}

function memcached_mixin {
    echo -e "${OK_COLOR}[minotor-mixin] Setup Memcached Mixin ${NO_COLOR}"
    monitoring_mixin "memcached-mixin" ${output} "alerts" "" "dashboards"
}


if [ "$#" -ne 1 ]; then
    usage
    exit 0
fi

output=$(pwd)/$1

kubernetes_mixin ${output}
node_exporter_mixin ${output}
prometheus_operator_mixin ${output}
prometheus_mixin ${output}
alertmanager_mixin ${output}
kube_state_metrics_mixin ${output}
thanos_mixin ${output}
cert_manager_mixin ${output}
grafana_mixin ${output}
loki_mixin ${output}
promtail_mixin ${output}
etcd_mixin ${output}
memcached_mixin ${output}

# TODO :

# elasticsearch_mixin
