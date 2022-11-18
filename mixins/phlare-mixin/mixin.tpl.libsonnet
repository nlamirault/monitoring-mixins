local phlare = import 'phlare-mixin/mixin.libsonnet';

phlare {
  _config+:: {
    tags: ['phlare-mixin', '${app}-${version}'],
  },
}
