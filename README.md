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

## Mixins

<!-- BEGIN_MIXINS_DOC -->
| Mixin | Version |
|-------|:-------:|
| alertmanager-mixin | https://github.com/prometheus/alertmanager.git - `v0.24.0` <br> |
| cert-manager-mixin | https://gitlab.com/uneeq-oss/cert-manager-mixin.git - `master` <br> |
| coredns-mixin | https://github.com/povilasv/coredns-mixin.git - `master` <br> |
| elasticsearch-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| fluxcd-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| grafana-agent-mixin | https://github.com/grafana/agent.git - `v0.25.0` <br> |
| grafana-mixin | https://github.com/grafana/grafana.git - `v8.5.5` <br> |
| istio-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| jaeger-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| kafka-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| kube-state-metrics-mixin | https://github.com/kubernetes/kube-state-metrics.git - `v2.5.0` <br> |
| kubernetes-mixin | https://github.com/kubernetes-monitoring/kubernetes-mixin.git - `master` <br> |
| linkerd-edge-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| linkerd-stable-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| loki-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/loki.git - `v2.5.0` <br> |
| memcached-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| mimir-mixin | https://github.com/grafana/mimir.git - `mimir-2.0.0` <br> |
| minio-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| nginx-ingress-controller-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| node-exporter-mixin | https://github.com/prometheus/node_exporter.git - `v1.3.1` <br> |
| osm-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| postgres-mixin | https://github.com/prometheus-community/postgres_exporter.git - `v0.10.1` <br> |
| prometheus-mixin | https://github.com/prometheus/prometheus.git - `v2.36.1` <br> |
| prometheus-operator-mixin | https://github.com/prometheus-operator/prometheus-operator.git - `v0.57.0` <br> |
| promtail-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/loki.git - `v2.5.0` <br> https://github.com/grafana/loki.git - `v2.5.0` <br> |
| rabbitmq-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| sealed-secrets-mixin | https://github.com/bitnami-labs/sealed-secrets.git - `v0.18.0` <br> |
| tempo-mixin | https://github.com/grafana/tempo.git - `v1.4.1` <br> |
| thanos-mixin | https://github.com/thanos-io/thanos.git - `v0.26.0` <br> |
<!-- END_MIXINS_DOC -->
