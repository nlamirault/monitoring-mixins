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

local kafka = import 'kafka-mixin/mixin.libsonnet';

kafka {
  _config+:: {
    kafkaFilteringSelector: 'job="integrations/kafka"',
    kafkaConnectSelector: 'job=~"integrations/kafka-connect|integrations/kafka"',
    zookeeperFilteringSelector: 'job=~"integrations/kafka-zookeeper|integrations/kafka"',
    schemaRegistryFilteringSelector: 'job=~"integrations/kafka-schemaregistry|integrations/kafka"',
    ksqldbFilteringSelector: 'job=~"integrations/kafka-ksqldb|integrations/kafka"',
    groupLabels: ['job', 'kafka_cluster'],
    instanceLabels: ['instance'],
    dashboardTags: ['kafka-integration'],
  },
}
