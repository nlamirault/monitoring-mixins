local pyroscope = import 'pyroscope-mixin/mixin.libsonnet';

pyroscope {
  _config+:: {
    tags: ['pyroscope-mixin', 'monitoring-mixins-1.4.0'],
  },
}
