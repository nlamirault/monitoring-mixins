local agent = import 'apollo-server-mixin/mixin.libsonnet';

agent {
  _config+:: {
    tags: ['apollo-server-mixin', 'monitoring-mixins-v1.7.1'],
  },
}
