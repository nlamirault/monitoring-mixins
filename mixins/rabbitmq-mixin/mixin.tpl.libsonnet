local rabbitmq = import 'rabbitmq-mixin/mixin.libsonnet';

rabbitmq {
  _config+:: {

    // runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/rabbitmq-mixin-runbook.md#alert-name-%s',
  },
}
