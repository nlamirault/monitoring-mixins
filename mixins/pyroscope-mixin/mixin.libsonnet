local pyroscope = import 'pyroscope-mixin/mixin.libsonnet';

pyroscope {
  _config+:: {
    tags: ['pyroscope-mixin', 'monitoring-mixins-v1.7.1'],
  },
}
