local tempo = import 'tempo-mixin/mixin.libsonnet';

tempo {
  _config+:: {
    tags: ['tempo-mixin', 'monitoring-mixins-v1.0.0'],
  },
}
