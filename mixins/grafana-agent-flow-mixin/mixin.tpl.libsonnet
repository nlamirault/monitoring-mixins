local agent = import 'grafana-agent-mixin/mixin.libsonnet';

agent {
  _config+:: {
    tags: ['grafana-agent-mixin', '${app}-${version}'],
  },
}
