local thanos = import 'mixin/mixin.libsonnet';

thanos {
  dashboard+:: {
    prefix: 'Thanos / ',
    tags: ['thanos-mixin', '__APP_VERSION__'],
    namespaceQuery: 'kube_pod_info',
  },
}
