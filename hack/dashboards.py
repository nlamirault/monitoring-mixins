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

# import abc
import argparse
import logging
from os import path

import coloredlogs
import requests


logger = logging.getLogger(__name__)

class MixinError(Exception):
    """Base class for exceptions in this module."""

    pass

class MixinNotFountError(MixinError):

    def __init__(self, name):
        self.name = name

    def __str__(self):
        return "Mixin not found: %s" % self.name

class Mixin():

    name = ""
    url = ""
    dashboards = []

    def __init__(self, name, version, dashboards):
        self.name = name
        logger.info("Setup mixin: %s [%s]. Dashboards: %s", self.name, version, dashboards)

    def _download_dashboard(self, dashboard):
        logger.info("Download dashboard: %s", dashboard)
        url = "%s/%s.json" % (self.url, dashboard)
        filename = "mixins/%s/dashboards/%s.json" % (self.name, dashboard)
        logger.debug("Dashboard URL: %s : %s", url, filename)
        r = requests.get(url)
        if r.status_code != 200:
            logger.error("Can't download dashboard: %s %s", r.text, url)
            return
        with open(filename, "wb") as f:
            f.write(r.content)

    def download(self):
        for dashboard in self.dashboards:
            self._download_dashboard(dashboard)


class MixinLinkerd(Mixin):

    _repo = "https://raw.githubusercontent.com/linkerd/linkerd2"
    dashboards = [
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

    def __init__(self, name):
        super().__init__(name, self._version, self.dashboards)
        self.url = "%s/%s/grafana/dashboards" % (self._repo, self._version)

class MixinLinkerdStable(MixinLinkerd):

    #datasource=github-tags depName=linkerd/linkerd2
    _version = "stable-2.11.2"

class MixinLinkerdEdge(MixinLinkerd):

    #datasource=github-tags depName=linkerd/linkerd2
    _version = "edge-22.3.5"



class NginxIngressControllerMixin(Mixin):

    _repo = "https://raw.githubusercontent.com/kubernetes/ingress-nginx"
    dashboards = [
        "nginx",
        "request-handling-performance"
    ]

    #datasource=github-tags depName=kubernetes/ingress-nginx
    _version = "controller-v1.2.0"

    def __init__(self, name):
        super().__init__(name, self._version, self.dashboards)
        self.url = "%s/%s/deploy/grafana/dashboards" % (self._repo, self._version)

class FluxCDMixin(Mixin):

    _repo = "https://raw.githubusercontent.com/fluxcd/flux2"
    dashboards = [
        "cluster",
        "control-plane"
    ]

    #datasource=github-tags depName=fluxcd/flux2
    _version = "v0.29.3"

    def __init__(self, name):
        super().__init__(name, self._version, self.dashboards)
        self.url = "%s/%s/manifests/monitoring/grafana/dashboards" % (self._repo, self._version)


class OsmMixin(Mixin):

    _repo = "https://raw.githubusercontent.com/openservicemesh/osm"
    dashboards = [
        "osm-control-plane",
        "osm-data-plane-performance",
        "osm-mesh-envoy-details",
        "osm-pod-to-service",
        "osm-service-to-service",
        "osm-workload-to-service",
        "osm-workload-to-workload"
    ]

    #datasource=github-tags depName=openservicemesh/osm
    _version = "v1.1.0"

    def __init__(self, name):
        super().__init__(name, self._version, self.dashboards)
        self.url = "%s/%s/charts/osm/grafana/dashboards" % (self._repo, self._version)


def main(name):
    mixin = None
    if name == "linkerd-stable-mixin":
        mixin = MixinLinkerdStable(name)
    elif name == "linkerd-edge-mixin":
        mixin = MixinLinkerdEdge(name)
    elif name == "nginx-ingress-controller-mixin":
        mixin = NginxIngressControllerMixin(name)
    elif name == "fluxcd-mixin":
        mixin = FluxCDMixin(name)
    elif name == "osm-mixin":
        mixin = OsmMixin(name)
    else:
        raise MixinNotFountError(name)
    mixin.download()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prefix_chars="-")
    parser.add_argument("mixin", type=str, help="Mixin to update")
    parser.add_argument("--log", type=str, default="info", help="Log level")
    args = parser.parse_args()
    coloredlogs.install(level=args.log)
    try:
        main(args.mixin)
    except MixinError as e:
        logger.error(str(e))
