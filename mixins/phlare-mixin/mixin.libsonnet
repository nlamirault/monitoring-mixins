local phlare = import 'phlare-mixin/mixin.libsonnet';

phlare {
  _config+:: {
    tags: ['phlare-mixin', 'monitoring-mixins-v1.7.1'],
  },
}
