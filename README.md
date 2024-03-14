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
| alertmanager-mixin | https://github.com/prometheus/alertmanager.git - `v0.27.0` <br> |
| apollo-server-mixin | https://github.com/bfmatei/apollo-prometheus-exporter.git - `v3.0.0` <br> |
| cert-manager-mixin | https://gitlab.com/uneeq-oss/cert-manager-mixin.git - `master` <br> |
| coredns-mixin | https://github.com/povilasv/coredns-mixin.git - `master` <br> |
| elasticsearch-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| fluxcd-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| grafana-agent-flow-mixin | https://github.com/grafana/agent.git - `v0.40.2` <br> |
| grafana-mixin | https://github.com/grafana/grafana.git - `v10.3.3` <br> |
| istio-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| jaeger-mixin | https://github.com/jaegertracing/jaeger - `v1.55.0` <br> |
| kafka-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| kube-state-metrics-mixin | https://github.com/kubernetes/kube-state-metrics.git - `v2.10.1` <br> |
| kubernetes-mixin | https://github.com/kubernetes-monitoring/kubernetes-mixin.git - `master` <br> |
| linkerd-edge-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| linkerd-stable-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| loki-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/loki.git - `v2.9.5` <br> |
| memcached-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| mimir-mixin | https://github.com/grafana/mimir.git - `mimir-2.9.0` <br> |
| minio-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| nginx-ingress-controller-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| node-exporter-mixin | https://github.com/prometheus/node_exporter.git - `v1.7.0` <br> |
| osm-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| phlare-mixin | https://github.com/grafana/phlare.git - `v0.6.1` <br> |
| postgres-mixin | https://github.com/prometheus-community/postgres_exporter.git - `v0.15.0` <br> |
| prometheus-mixin | https://github.com/prometheus/prometheus.git - `v2.50.1` <br> |
| prometheus-operator-mixin | https://github.com/prometheus-operator/prometheus-operator.git - `v0.72.0` <br> |
| promtail-mixin | https://github.com/grafana/grafonnet-lib.git - `master` <br> https://github.com/grafana/loki.git - `v2.9.5` <br> https://github.com/grafana/loki.git - `v2.9.5` <br> |
| pyroscope-mixin | https://github.com/grafana/pyroscope.git - `v1.4.0` <br> |
| rabbitmq-mixin | https://github.com/grafana/jsonnet-libs.git - `master` <br> |
| sealed-secrets-mixin | https://github.com/bitnami-labs/sealed-secrets.git - `v0.26.0` <br> |
| tempo-mixin | https://github.com/grafana/tempo.git - `v2.4.0` <br> |
| thanos-mixin | https://github.com/thanos-io/thanos.git - `v0.34.1` <br> |
<!-- END_MIXINS_DOC -->
