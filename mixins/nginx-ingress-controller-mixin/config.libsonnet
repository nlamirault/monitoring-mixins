{
  _config+:: {
    runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixin/tree/master/runbook.md#alert-name-%s',

    // Severity level for NGINXConfigFailed alert
    NGINXConfigFailedSeverity: 'warning',
    // Severity level for NGINXTooMany500s alert
    NGINXTooMany500sSeverity: 'warning',
    // Severity level for NGINXTooMany400s alert
    NGINXTooMany400sSeverity: 'warning',

    // Config for the Grafana dashboards in the Mixin
    // grafanaK8s: {
    //   prefix: 'Kubernetes / ',
    //   tags: ['nginx-ingress-controller-mixin'],

    //   // The default refresh time for all dashboards, default to 10s
    //   refresh: '60s',
    //   // minimumTimeInterval: '1m',
    // },

  },

}
