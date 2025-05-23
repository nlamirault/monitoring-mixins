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

local kubernetes = import 'prometheus-mixin/mixin.libsonnet';

kubernetes {
  _config+:: {

    prometheusSelector: 'job="prometheus"',

    // prometheusName is inserted into annotations to name the Prometheus
    // instance affected by the alert.
    prometheusName: '{{.instance}}',

    grafana: {
      prefix: 'Prometheus / ',
      tags: ['prometheus-mixin', 'monitoring-mixins-v1.12.0'],
      // The default refresh time for all dashboards, default to 60s
      refresh: '60s',
    },

    runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/prometheus-mixin-runbook.md#alert-name-%s',
  },
}
