local elasticsearch = import 'elasticsearch-mixin/mixin.libsonnet';

elasticsearch {
  _config+:: {

    // runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/elasticsearch-mixin-runbook.md#alert-name-%s',
  },
}
