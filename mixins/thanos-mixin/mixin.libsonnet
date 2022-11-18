local thanos = import 'mixin/mixin.libsonnet';

thanos {
  dashboard+:: {
    prefix: 'Thanos / ',
    tags: ['thanos-mixin', 'monitoring-mixins-v1.0.0'],
    namespaceQuery: 'kube_pod_info',
  },
}
