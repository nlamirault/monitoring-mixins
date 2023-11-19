local mimir = import 'mimir-mixin/mixin.libsonnet';

mimir {
  _config+:: {
    tags: ['mimir-mixin', 'monitoring-mixins-v1.6.0'],
  },
}
