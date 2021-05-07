local thanos = import 'mixin/mixin.libsonnet';

thanos {
  dashboard+:: {
    prefix: 'Thanos / ',
    tags: ['thanos-mixin', '${app}-v${version}'],
    namespaceQuery: 'kube_pod_info',
  },
}
