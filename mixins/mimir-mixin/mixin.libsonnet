local mimir = import 'mimir-mixin/mixin.libsonnet';

mimir {
  _config+:: {
    tags: ['mimir-mixin', 'monitoring-mixins-v0.23.0'],
  },
}
