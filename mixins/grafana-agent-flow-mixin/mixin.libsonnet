local agent = import 'agent-flow-mixin/mixin.libsonnet';

agent {
  _config+:: {
    tags: ['grafana-agent-flow-mixin', 'monitoring-mixins-1.4.0'],
  },
}
