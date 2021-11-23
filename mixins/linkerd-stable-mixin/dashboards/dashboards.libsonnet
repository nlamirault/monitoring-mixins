// Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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
  grafanaDashboards: {
    'linkerd_authority_dashboard.json': (import 'authority.json'),
    'linkerd_cronjob_dashboard.json': (import 'cronjob.json'),
    'linkerd_daemonset_dashboard.json': (import 'daemonset.json'),
    'linkerd_deployment_dashboard.json': (import 'deployment.json'),
    'linkerd_health_dashboard.json': (import 'health.json'),
    'linkerd_job_dashboard.json': (import 'job.json'),
    'linkerd_multicluster_dashboard.json': (import 'multicluster.json'),
    'linkerd_namespace_dashboard.json': (import 'namespace.json'),
    'linkerd_pod_dashboard.json': (import 'pod.json'),
    'linkerd_replicaset_dashboard.json': (import 'replicaset.json'),
    'linkerd_replicationcontroller_dashboard.json': (import 'replicationcontroller.json'),
    'linkerd_route_dashboard.json': (import 'route.json'),
    'linkerd_statefulset_dashboard.json': (import 'statefulset.json'),
    'linkerd_top-line_dashboard.json': (import 'top-line.json'),
  },
}
