local kubernetes = import 'kubernetes-mixin/mixin.libsonnet';

kubernetes {
  _config+:: {
    cadvisorSelector: 'job="kubelet"',  // or cadvisor ?
    kubeletSelector: 'job="kubelet"',
    kubeStateMetricsSelector: 'job="kube-state-metrics"',
    nodeExporterSelector: 'job="node-exporter"',
    kubeSchedulerSelector: 'job="kube-scheduler"',
    kubeControllerManagerSelector: 'job="kube-controller-manager"',
    kubeApiserverSelector: 'job="kube-apiserver"',
    kubeProxySelector: 'job="kube-proxy"',

    grafanaK8s: {
      dashboardNamePrefix: 'Kubernetes / ',
      dashboardTags: ['kubernetes-mixin', 'monitoring-mixins-v1.5.0'],
      linkPrefix: '.',

      // The default refresh time for all dashboards, default to 10s
      refresh: '60s',
      minimumTimeInterval: '1m',

      // Timezone for Grafana dashboards:: UTC, browser, ...
      grafanaTimezone: 'UTC',
    },

    runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/kubernetes-mixin-runbook.md#alert-name-%s',
  },
}
