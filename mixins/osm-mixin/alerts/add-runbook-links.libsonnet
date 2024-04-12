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

local utils = import '../lib/utils.libsonnet';

local lower(x) =
  local cp(c) = std.codepoint(c);
  local lowerLetter(c) =
    if cp(c) >= 65 && cp(c) < 91
    then std.char(cp(c) + 32)
    else c;
  std.join('', std.map(lowerLetter, std.stringChars(x)));

{
  _config+:: {
    runbookURLPattern: 'https://github.com/portefaix/portefaix-mixin/tree/master/runbook.md#alert-name-%s',
  },

  prometheusAlerts+::
    local addRunbookURL(rule) = rule {
      [if 'alert' in rule && !('runbook_url' in rule.annotations) then 'annotations']+: {
        runbook_url: $._config.runbookURLPattern % lower(rule.alert),
      },
    };
    utils.mapRuleGroups(addRunbookURL),
}
