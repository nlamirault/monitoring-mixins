local agent = import 'grafana-agent-mixin/mixin.libsonnet';

agent {
  _config+:: {
    tags: ['grafana-agent-mixin', 'portefaix-0.0.0'],
  },
}
