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
    'osm-control-plane.json': (import 'osm-control-plane.json'),
    'osm-data-plane-performance.json': (import 'osm-data-plane-performance.json'),
    'osm-mesh-envoy-details.json': (import 'osm-mesh-envoy-details.json'),
    'osm-pod-to-service.json': (import 'osm-pod-to-service.json'),
    'osm-service-to-service.json': (import 'osm-service-to-service.json'),
    'osm-workload-to-service.json': (import 'osm-workload-to-service.json'),
    'osm-workload-to-workload.json': (import 'osm-workload-to-workload.json'),
  },
}
