local memcached = import 'memcached-mixin/mixin.libsonnet';

memcached {
  _config+:: {

    // runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/memcached-mixin-runbook.md#alert-name-%s',
  },
}
