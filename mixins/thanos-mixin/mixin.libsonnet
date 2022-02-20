local thanos = import 'mixin/mixin.libsonnet';

thanos {
  dashboard+:: {
    prefix: 'Thanos / ',
    tags: ['thanos-mixin', 'monitoring-mixins-V0.15.0'],
    namespaceQuery: 'kube_pod_info',
  },
}
