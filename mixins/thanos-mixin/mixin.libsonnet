local thanos = import 'mixin/mixin.libsonnet';

thanos {
  dashboard+:: {
    prefix: 'Thanos / ',
    tags: ['thanos-mixin', 'monitoring-mixins-0.17.0'],
    namespaceQuery: 'kube_pod_info',
  },
}
