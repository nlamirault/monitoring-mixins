local thanos = import 'mixin/mixin.libsonnet';

thanos {
  dashboard+:: {
    prefix: 'Thanos / ',
    tags: ['thanos-mixin', 'monitoring-mixins-v0.23.0'],
    namespaceQuery: 'kube_pod_info',
  },
}
