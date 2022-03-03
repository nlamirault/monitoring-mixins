# Monitoring Mixins

The monitoring-mixins is a collection of reusable and configurable
[Prometheus](https://prometheus.io/) alerts, and [Grafana](https://grafana.com)
dashboards.

### Usage

Generate Prometheus rules/alerts for Prometheus and Kubernetes format, and Grafana dashboards

```shell
❯ make mixins APP=monitoring-mixins VERSION=0.7.0
```

Generate a mixin:

```shell
❯ make mixin APP=monitoring-mixins VERSION=0.7.0 MIXIN=kube-state-metrics-mixin
```

## Description

| Mixin | Version |
|-------|:-------:|
<!-- BEGIN_MIXINS_DOC -->
| alertmanager-mixin | "https://github.com/prometheus/alertmanager.git - `v0.23.0"` , |
| cert-manager-mixin | "https://gitlab.com/uneeq-oss/cert-manager-mixin.git - `master"` , |
| coredns-mixin | "https://github.com/povilasv/coredns-mixin.git - `master"` , |
| elasticsearch-mixin | "https://github.com/grafana/jsonnet-libs.git - `master"` , |
| fluxcd-mixin | "https://github.com/grafana/grafonnet-lib.git - `master"` , "https://github.com/grafana/jsonnet-libs.git - `master"` , |
| grafana-mixin | "https://github.com/grafana/grafana.git - `v8.4.3"` , |
| kubernetes-mixin | "https://github.com/kubernetes-monitoring/kubernetes-mixin.git - `release-0.8"` , |
| kube-state-metrics-mixin | "https://github.com/kubernetes/kube-state-metrics.git - `v2.4.1"` , |
| linkerd-edge-mixin | "https://github.com/grafana/grafonnet-lib.git - `master"` , "https://github.com/grafana/jsonnet-libs.git - `master"` , |
| linkerd-stable-mixin | "https://github.com/grafana/grafonnet-lib.git - `master"` , "https://github.com/grafana/jsonnet-libs.git - `master"` , |
| loki-mixin | "https://github.com/grafana/grafonnet-lib.git - `master"` , "https://github.com/grafana/loki.git - `v2.4.2"` , |
| memcached-mixin | "https://github.com/grafana/jsonnet-libs.git - `master"` , |
| minio-mixin | "https://github.com/grafana/jsonnet-libs.git - `master"` , |
| nginx-ingress-controller-mixin | "https://github.com/grafana/grafonnet-lib.git - `master"` , "https://github.com/grafana/jsonnet-libs.git - `master"` , |
| node-exporter-mixin | "https://github.com/prometheus/node_exporter.git - `v1.3.1"` , |
| osm-mixin | "https://github.com/grafana/grafonnet-lib.git - `master"` , "https://github.com/grafana/jsonnet-libs.git - `master"` , |
| prometheus-mixin | "https://github.com/prometheus/prometheus.git - `v2.33.4"` , |
| prometheus-operator-mixin | "https://github.com/prometheus-operator/prometheus-operator.git - `v0.54.1"` , |
| promtail-mixin | "https://github.com/grafana/grafonnet-lib.git - `master"` , "https://github.com/grafana/loki.git - `v2.4.2"` , "https://github.com/grafana/loki.git - `v2.4.2"` , |
| rabbitmq-mixin | "https://github.com/grafana/jsonnet-libs.git - `master"` , |
| thanos-mixin | "https://github.com/thanos-io/thanos.git - `v0.24.0"` , |
<!-- END_MIXINS_DOC -->
