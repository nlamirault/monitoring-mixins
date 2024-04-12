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

local alertmanager = import 'alertmanager-mixin/mixin.libsonnet';

alertmanager {
  _config+:: {
    local c = self,
    // alertmanagerSelector is inserted as part of the label selector in
    // PromQL queries to identify metrics collected from Alertmanager
    // servers.
    alertmanagerSelector: 'job="alertmanager"',

    // alertmanagerClusterLabels is a string with comma-separated
    // labels that are common labels of instances belonging to the
    // same Alertmanager cluster. Include not only enough labels to
    // identify cluster members, but also all common labels you want
    // to keep for resulting cluster-level alerts.
    alertmanagerClusterLabels: 'job',

    // alertmanagerNameLabels is a string with comma-separated
    // labels used to identify different alertmanagers within the same
    // Alertmanager HA cluster.
    // If you run Alertmanager on Kubernetes with the Prometheus
    // Operator, you can make use of the configured target labels for
    // nicer naming:
    // alertmanagerNameLabels: 'namespace,pod'
    alertmanagerNameLabels: 'instance',

    // alertmanagerName is an identifier for alerts. By default, it is built from 'alertmanagerNameLabels'.
    alertmanagerName: std.join('/', ['{{.%s}}' % [label] for label in std.split(c.alertmanagerNameLabels, ',')]),

    // alertmanagerClusterName is inserted into annotations to name an
    // Alertmanager cluster. All labels used here must also be present
    // in alertmanagerClusterLabels above.
    alertmanagerClusterName: '{{.job}}',

    // alertmanagerCriticalIntegrationsRegEx is matched against the
    // value of the `integration` label to determine if the
    // AlertmanagerClusterFailedToSendAlerts is critical or merely a
    // warning. This can be used to avoid paging about a failed
    // integration that is itself not used for critical alerts.
    // Example: @'pagerduty|webhook'
    alertmanagerCriticalIntegrationsRegEx: @'.*',

    dashboardNamePrefix: 'Alertmanager / ',
    dashboardTags: ['alertmanager-mixin', 'monitoring-mixins-v1.7.1'],
  },
}
