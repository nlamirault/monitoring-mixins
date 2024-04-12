{
  _config+:: {
    runbookURLPattern: 'https://github.com/nlamiraut/monitoring-mixins/tree/master/mixins/linkerd-stable-mixin/runbook.md#alert-name-%s',

    // Severity level for LinkerdRequestsHighErrorRate alert
    LinkerdRequestsHighErrorRateSeverity: 'warning',

    // Config for the Grafana dashboards in the Mixin
    grafanaK8s: {
      prefix: 'Linkerd / ',
      tags: ['linkerd-mixin', 'linkerd-stable'],

      // The default refresh time for all dashboards, default to 10s
      refresh: '60s',
      // minimumTimeInterval: '1m',
    },

  },

}
