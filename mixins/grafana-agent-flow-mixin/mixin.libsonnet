local agent = import 'grafana-agent-flow-mixin/mixin.libsonnet';

agent {
  _config+:: {
    tags: ['grafana-agent-flow-mixin', 'monitoring-mixins-v1.4.0'],
  },
}
