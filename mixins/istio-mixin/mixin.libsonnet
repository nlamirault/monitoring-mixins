local istio = import 'istio-mixin/mixin.libsonnet';

istio {
  _config+:: {
    runbookURLPattern: 'https://github.com/nlamirault/monitoring-mixins/tree/master/runbooks/istio-mixin-runbook.md#alert-name-%s',
  },
}
