// Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// SPDX-License-Identifier: Apache-2.0

local kubernetes = import 'kubernetes-mixin/mixin.libsonnet';

kubernetes {
  _config+:: {
    cadvisorSelector: 'job="kubelet"',  // or cadvisor ?
    kubeletSelector: 'job="kubelet"',
    kubeStateMetricsSelector: 'job="kube-state-metrics"',
    nodeExporterSelector: 'job="node-exporter"',
    kubeSchedulerSelector: 'job="kube-scheduler"',
    kubeControllerManagerSelector: 'job="kube-controller-manager"',
    kubeApiserverSelector: 'job="kube-apiserver"',
    kubeProxySelector: 'job="kube-proxy"',

    grafanaK8s: {
      dashboardNamePrefix: 'Kubernetes / ',
      dashboardTags: ['kubernetes-mixin', 'monitoring-mixins-v1.12.0'],
      linkPrefix: '.',

      // The default refresh time for all dashboards, default to 10s
      refresh: '60s',
      minimumTimeInterval: '1m',

      // Timezone for Grafana dashboards:: UTC, browser, ...
      grafanaTimezone: 'UTC',
    },

    runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/kubernetes-mixin-runbook.md#alert-name-%s',
  },
}
