{
  prometheusAlerts+:: {
    groups+: [{
      name: 'linkerd',
      rules: [
        {
          alert: 'LinkerdRequestsHighErrorRate',
          expr: 'sum(rate(request_errors_total[1m])) by (deployment, statefulset, daemonset) / sum(rate(request_total[1m])) by (deployment, statefulset, daemonset) * 100 > 10' % $._config,
          'for': '10m',
          labels: {
            severity: '%(LinkerdRequestsHighErrorRateSeverity)s' % $._config,
          },
          annotations: {
            summary: 'Linkerd have high error rate for more than 10 minutes.',
            message: 'Linkerd error rate for {{ $labels.deployment | $labels.statefulset | $labels.daemonset }}.',
          },
        },
      ],
    }],
  },
}
