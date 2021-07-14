// Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

{
  prometheusAlerts+:: {
    groups+: [{
      name: 'ingress-controller',
      rules: [
        {
          alert: 'NGINXConfigFailed',
          expr: 'count(nginx_ingress_controller_config_last_reload_successful == 0) > 0',
          'for': '10m',
          labels: {
            severity: '%(NGINXConfigFailedSeverity)s' % $._config,
          },
          annotations: {
            summary: 'Nginx reload configuration failed.',
            message: 'Bad Ingress configuration. Nginx configuration test failed.',
          },
        },
        {
          alert: 'NGINXTooMany500s',
          expr: '100 * ( sum( nginx_ingress_controller_requests{status=~"5.+"} ) / sum(nginx_ingress_controller_requests) ) > 5',
          'for': '10m',
          labels: {
            severity: '%(NGINXTooMany500sSeverity)s' % $._config,
          },
          annotations: {
            summary: 'Too many 5XXs.',
            message: 'More than 5% of all requests returned 5XX, this requires your attention.',
          },
        },
        {
          alert: 'NGINXTooMany400s',
          expr: '100 * ( sum( nginx_ingress_controller_requests{status=~"4.+"} ) / sum(nginx_ingress_controller_requests) ) > 5',
          'for': '10m',
          labels: {
            severity: '%(NGINXTooMany400sSeverity)s' % $._config,
          },
          annotations: {
            summary: 'Too many 4XXs.',
            message: 'More than 5% of all requests returned 4XX, this requires your attention.',
          },
        },
      ],
    }],
  },
}
