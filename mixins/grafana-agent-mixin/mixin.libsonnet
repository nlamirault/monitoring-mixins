local agent = import 'grafana-agent-mixin/mixin.libsonnet';

agent {
  _config+:: {
    tags: ['grafana-agent-mixin', 'monitoring-mixins-v1.4.0'],
  },
}
