local agent = import 'apollo-server-mixin/mixin.libsonnet';

agent {
  _config+:: {
    tags: ['apollo-server-mixin', 'portefaix-0.0.0'],
  },
}
