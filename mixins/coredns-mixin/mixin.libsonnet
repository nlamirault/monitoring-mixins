local alertmanager = import 'coredns-mixin/mixin.libsonnet';

alertmanager {
  _config+:: {
    corednsSelector: 'job="coredns"',
    instanceLabel: 'pod',

    grafanaDashboardIDs: {
      'coredns.json': 'thael1rie7ohG6OY3eMeisahtee2iGoo1gooGhuu',
    },

    pluginNameLabel: 'name',
    kubernetesPlugin: false,
    grafana: {
      dashboardNamePrefix: 'Kubernetes / ',
      dashboardTags: ['coredns-mixin', 'monitoring-mixins-v1.7.1'],

      // The default refresh time for all dashboards, default to 10s
      refresh: '60s',
    },
  },
}
