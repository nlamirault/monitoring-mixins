local postgres = import 'postgres_mixin/mixin.libsonnet';

postgres {
  _config+:: {
    postgresExporterSelector: '',
    // tags: ['postgres-mixin', 'monitoring-mixins-v1.7.0'],
    // runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/postgres-mixin-runbook.md#alert-name-%s',
  },
}
