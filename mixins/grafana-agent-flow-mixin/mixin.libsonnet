local agent = import 'agent-flow-mixin/mixin.libsonnet';

agent {
  _config+:: {
    tags: ['grafana-agent-flow-mixin', 'portefaix-0.0.0'],
  },
}
