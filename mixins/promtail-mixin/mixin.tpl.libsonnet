local promtail = import 'promtail-mixin/mixin.libsonnet';

promtail {
  _config+:: {

    // runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/promtail-mixin-runbook.md#alert-name-%s',
  },
}
