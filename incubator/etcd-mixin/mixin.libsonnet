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

local etcd = import 'etcd-mixin/mixin.libsonnet';

etcd {
  _config+:: {
    etcd_selector: 'job=~".*etcd.*"',
    // etcd_instance_labels are the label names that are uniquely
    // identifying an instance and need to be aggreated away for alerts
    // that are about an etcd cluster as a whole. For example, if etcd
    // instances are deployed on K8s, you will likely want to change
    // this to 'instance, pod'.
    etcd_instance_labels: 'instance',
    // scrape_interval_seconds is the global scrape interval which can be
    // used to dynamically adjust rate windows as a function of the interval.
    scrape_interval_seconds: 30,

    // runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/etcd-mixin-runbook.md#alert-name-%s',
  },
}
