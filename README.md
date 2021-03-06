# Monitoring Mixins

The monitoring-mixins is a collection of reusable and configurable
[Prometheus](https://prometheus.io/) alerts, and [Grafana](https://grafana.com)
dashboards.

## Description

### Mixins

| Mixin | Version |
|-------|:-------:|
| [kubernetes-mixin](https://monitoring.mixins.dev/kubernetes) | `release-0.6` |
| [node-exporter-mixin](https://monitoring.mixins.dev/node-exporter) | `master` | 
| [prometheus-mixin](https://monitoring.mixins.dev/prometheus) | `v2.24.0` |
| [prometheus-operator-mixin](https://monitoring.mixins.dev/prometheus-operator) | `v0.44.1` |
| [thanos-mixin](https://monitoring.mixins.dev/thanos) | `v0.18.0-rc.0` |
| [alertmanager-mixin](https://monitoring.mixins.dev/alertmanager) | `master` | 
| [kube-state-metrics-mixin](https://monitoring.mixins.dev/kube-state-metrics) | `v2.0.0-beta` |
| [cert-manager-mixin](https://monitoring.mixins.dev/cert-manager) | `master` |
| [grafana-mixin](https://github.com/grafana/grafana/tree/master/grafana-mixin) | `v7.3.6` |
| [loki-mixin](https://github.com/grafana/loki/tree/master/production/loki-mixin) | `v2.1.0`  |
| [promtail-mixin](https://monitoring.mixins.dev/promtail) | `v2.1.0` |
| [etcd-mixin](https://github.com/etcd-io/etcd/tree/master/Documentation/etcd-mixin) | `v3.4.14` |
| [memcached-mixin](https://monitoring.mixins.dev/memcached) | `master` |

### Mixin

Generate Prometheus rules/alerts for Prometheus and Kubernetes format, and Grafana dashboards

```shell
❯ make mixins
```
