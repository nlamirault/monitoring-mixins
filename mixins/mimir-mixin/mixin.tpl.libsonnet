local mimir = import 'mimir-mixin/mixin.libsonnet';

mimir {
  _config+:: {
    tags: ['mimir-mixin', '${app}-${version}'],
  },
}
