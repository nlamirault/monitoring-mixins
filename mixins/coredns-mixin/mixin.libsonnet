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

local alertmanager = import 'coredns-mixin/mixin.libsonnet';

alertmanager {
  _config+:: {
    corednsSelector: 'job="coredns"',
    instanceLabel: 'pod',

    grafanaDashboardIDs: {
      'coredns.json': 'thael1rie7ohG6OY3eMeisahtee2iGoo1gooGhuu',
    },

    pluginNameLabel: 'name',
    kubernetesPlugin: false,
    grafana: {
      dashboardNamePrefix: 'Kubernetes / ',
      dashboardTags: ['coredns-mixin', 'monitoring-mixins-v1.12.0'],

      // The default refresh time for all dashboards, default to 10s
      refresh: '60s',
    },
  },
}
