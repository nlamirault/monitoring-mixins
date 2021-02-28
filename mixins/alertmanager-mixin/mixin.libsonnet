local alertmanager = import "alertmanager-mixin/mixin.libsonnet";

alertmanager {
  _config+:: {
    // alertmanagerSelector is inserted as part of the label selector in
    // PromQL queries to identify metrics collected from Alertmanager
    // servers.
    alertmanagerSelector: 'job="alertmanager"',

    // alertmanagerClusterLabels is a string with comma-separated
    // labels that are common labels of instances belonging to the
    // same Alertmanager cluster. Include not only enough labels to
    // identify cluster members, but also all common labels you want
    // to keep for resulting cluster-level alerts.
    alertmanagerClusterLabels: 'job',

    // alertmanagerName is inserted into annotations to name the Alertmanager
    // instance affected by the alert.
    alertmanagerName: '{{$labels.instance}}',
    // If you run Alertmanager on Kubernetes with the Prometheus
    // Operator, you can make use of the configured target labels for
    // nicer naming:
    // alertmanagerName: '{{$labels.namespace}}/{{$labels.pod}}'

    // alertmanagerClusterName is inserted into annotations to name an
    // Alertmanager cluster. All labels used here must also be present
    // in alertmanagerClusterLabels above.
    alertmanagerClusterName: '{{$labels.job}}',

    // runbookURLPattern: 'https://doc.skale-5.com/run/runbook.md#alert-name-%s',

  },
}