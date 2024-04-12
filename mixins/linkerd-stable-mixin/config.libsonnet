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

{
  _config+:: {
    runbookURLPattern: 'https://github.com/nlamiraut/monitoring-mixins/tree/master/mixins/linkerd-stable-mixin/runbook.md#alert-name-%s',

    // Severity level for LinkerdRequestsHighErrorRate alert
    LinkerdRequestsHighErrorRateSeverity: 'warning',

    // Config for the Grafana dashboards in the Mixin
    grafanaK8s: {
      prefix: 'Linkerd / ',
      tags: ['linkerd-mixin', 'linkerd-stable'],

      // The default refresh time for all dashboards, default to 10s
      refresh: '60s',
      // minimumTimeInterval: '1m',
    },

  },

}
