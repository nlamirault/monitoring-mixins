{
  _config+:: {
    runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixin/tree/master/runbook.md#alert-name-%s',

    // Severity level for ReconciliationFailure alert
    ReconciliationFailureSeverity: 'warning',

    // Config for the Grafana dashboards in the Mixin
    // grafanaK8s: {
    //   prefix: 'FluxCD / ',
    //   tags: ['fluxcd-mixin'],

    //   // The default refresh time for all dashboards, default to 10s
    //   refresh: '60s',
    //   // minimumTimeInterval: '1m',
    // },

  },

}
