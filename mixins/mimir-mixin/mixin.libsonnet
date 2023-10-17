local mimir = import 'mimir-mixin/mixin.libsonnet';

mimir {
  _config+:: {
    tags: ['mimir-mixin', 'monitoring-mixins-1.4.0'],
  },
}
