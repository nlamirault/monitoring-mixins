local loki = import 'loki-mixin/mixin.libsonnet';

loki {
  _config+:: {
    tags: ['loki-mixin', 'monitoring-mixins-v1.0.0'],

    // runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/loki-mixin-runbook.md#alert-name-%s',
  },
}
