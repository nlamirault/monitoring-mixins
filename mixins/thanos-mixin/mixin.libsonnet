local thanos = import 'mixin/mixin.libsonnet';

thanos {
  dashboard+:: {
    prefix: 'Thanos / ',
    tags: ['thanos-mixin', 'foo-0.0.0'],
    namespaceQuery: 'kube_pod_info',
  },
}
