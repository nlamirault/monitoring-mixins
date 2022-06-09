local tempo = import 'tempo-mixin/mixin.libsonnet';

tempo {
  _config+:: {
    tags: ['tempo-mixin', '${app}-${version}'],
  },
}
