local pyroscope = import 'pyroscope-mixin/mixin.libsonnet';

pyroscope {
  _config+:: {
    tags: ['pyroscope-mixin', 'portefaix-0.0.0'],
  },
}
