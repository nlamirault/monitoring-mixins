local minio = import 'minio-mixin/mixin.libsonnet';

minio {
  _config+:: {
    // runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/minio-mixin-runbook.md#alert-name-%s',
  },
}
