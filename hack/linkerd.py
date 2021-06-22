#!/usr/bin/env python3
# 
# # Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import argparse
import logging
from os import path

import coloredlogs
import requests

LINKERD_URL="https://raw.githubusercontent.com/linkerd/linkerd2"
LINKERD_DASHBOARDS=[
    "authority",
    "cronjob",
    "daemonset",
    "deployment",
    "health",
    "job",
    "multicluster",
    "namespace",
    "pod",
    "replicaset",
    "replicationcontroller",
    "route",
    "service",
    "statefulset",
    "top-line"
]

logger = logging.getLogger(__name__)


def download_dashboard(chart, version, dashboard):
    logger.info("Download dashboard : %s", dashboard)
    url = "%s/%s/grafana/dashboards/%s.json" % (LINKERD_URL, version, dashboard)
    logger.debug("Dashboard URL: %s", url)
    filename = "mixins/%s/dashboards/%s.json" % (chart, dashboard)
    r = requests.get(url)
    with open(filename, "wb") as f:
        f.write(r.content)

def main(mixin, version):
    for dashboard in LINKERD_DASHBOARDS:
        download_dashboard(mixin, version, dashboard)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(prefix_chars="-")
    parser.add_argument("mixin", type=str, help="Mixin to update")
    parser.add_argument("version", type=str, help="Linkerd version")
    parser.add_argument("--log", type=str, default="info", help="Log level")
    args = parser.parse_args()
    coloredlogs.install(level=args.log)
    main(args.mixin, args.version)
