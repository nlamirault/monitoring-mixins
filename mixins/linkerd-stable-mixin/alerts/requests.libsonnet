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
  prometheusAlerts+:: {
    groups+: [{
      name: 'linkerd',
      rules: [
        {
          alert: 'LinkerdRequestsHighErrorRate',
          expr: 'sum(rate(request_errors_total[1m])) by (deployment, statefulset, daemonset) / sum(rate(request_total[1m])) by (deployment, statefulset, daemonset) * 100 > 10' % $._config,
          'for': '10m',
          labels: {
            severity: '%(LinkerdRequestsHighErrorRateSeverity)s' % $._config,
          },
          annotations: {
            summary: 'Linkerd have high error rate for more than 10 minutes.',
            message: 'Linkerd error rate for {{ $labels.deployment | $labels.statefulset | $labels.daemonset }}.',
          },
        },
      ],
    }],
  },
}
