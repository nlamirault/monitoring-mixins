local kubernetes = import 'prometheus-mixin/mixin.libsonnet';

kubernetes {
  _config+:: {

    prometheusSelector: 'job="prometheus"',

    // prometheusName is inserted into annotations to name the Prometheus
    // instance affected by the alert.
    prometheusName: '{{$labels.instance}}',

    grafana: {
      prefix: 'Prometheus / ',
      tags: ['prometheus-mixin', '${app}-${version}'],
      // The default refresh time for all dashboards, default to 60s
      refresh: '60s',
    },

    runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/prometheus-mixin-runbook.md#alert-name-%s',
  },
}
