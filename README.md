# Monitoring Mixins

The monitoring-mixins is a collection of reusable and configurable
[Prometheus](https://prometheus.io/) alerts, and [Grafana](https://grafana.com)
dashboards.

## Description

| Mixin | Version |
|-------|:-------:|
| [kubernetes-mixin](https://monitoring.mixins.dev/kubernetes) | `release-0.9` |
| [node-exporter-mixin](https://monitoring.mixins.dev/node-exporter) | `v1.2.2` |
| [prometheus-mixin](https://monitoring.mixins.dev/prometheus) | `v2.29.1` |
| [prometheus-operator-mixin](https://monitoring.mixins.dev/prometheus-operator) | `v0.50.0` |
| [thanos-mixin](https://monitoring.mixins.dev/thanos) | `v0.22.0` |
| [alertmanager-mixin](https://monitoring.mixins.dev/alertmanager) | `v0.22.0` |
| [kube-state-metrics-mixin](https://monitoring.mixins.dev/kube-state-metrics) | `v2.2.0` |
| [cert-manager-mixin](https://monitoring.mixins.dev/cert-manager) | `master` |
| [grafana-mixin](https://github.com/grafana/grafana/tree/master/grafana-mixin) | `v8.0.0` |
| [loki-mixin](https://github.com/grafana/loki/tree/master/production/loki-mixin) | `v2.2.0`  |
| [promtail-mixin](https://monitoring.mixins.dev/promtail) | `v2.2.0` |
| [etcd-mixin](https://github.com/etcd-io/etcd/tree/master/Documentation/etcd-mixin) | `v3.4.14` |
| [memcached-mixin](https://monitoring.mixins.dev/memcached) | `master` |
| [elasticsearch-mixin](https://github.com/grafana/jsonnet-libs/tree/master/elasticsearch-mixin) | `master` |
| [rabbitmq-mixin](https://github.com/grafana/jsonnet-libs/tree/master/rabbitmq-mixin) | `master` |
| [linkerd-stable-mixin](https://github.com/nlamirault/monitoring-mixins/tree/master/mixins/linkerd-stable-mixin) | `stable-2.10.2` | 
| [linkerd-edge-mixin](https://github.com/nlamirault/monitoring-mixins/tree/master/mixins/linkerd-edge-mixin) | `edge-21.6.3` |
| [coredns-mixin](https://github.com/povilasv/coredns-mixin) | `master` |

### Usage

Generate Prometheus rules/alerts for Prometheus and Kubernetes format, and Grafana dashboards

```shell
❯ make mixins APP=monitoring-mixins VERSION=0.7.0
```

Generate a mixin:

```shell
❯ make mixin APP=monitoring-mixins VERSION=0.7.0 MIXIN=kube-state-metrics-mixin
```
