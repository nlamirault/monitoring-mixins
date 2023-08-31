local pyroscope = import 'pyroscope-mixin/mixin.libsonnet';

pyroscope {
  _config+:: {
    tags: ['pyroscope-mixin', '${app}-${version}'],
  },
}
