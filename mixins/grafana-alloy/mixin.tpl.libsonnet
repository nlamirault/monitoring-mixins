local agent = import 'alloy-mixin/mixin.libsonnet';

agent {
  _config+:: {
    tags: ['alloy-mixin', '${app}-${version}'],
  },
}
