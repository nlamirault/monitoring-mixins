local kubestatemetrics = import 'kube-state-metrics-mixin/mixin.libsonnet';

kubestatemetrics {
  _config+:: {
    // Select the metrics coming from the kube state metrics.
    kubeStateMetricsSelector: 'job="kube-state-metrics"',

    runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/kube-state-metrics-mixin-runbook.md#alert-name-%s',
  },
}
