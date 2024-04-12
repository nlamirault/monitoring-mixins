{
  prometheusAlerts+:: {
    groups+: [{
      name: 'fluxcd',
      rules: [
        {
          alert: 'ReconciliationFailure',
          expr: 'max(gotk_reconcile_condition{status="False",type="Ready"}) by (namespace, name, kind) + on(namespace, name, kind) (max(gotk_reconcile_condition{status="Deleted"}) by (namespace, name, kind)) * 2 == 1',
          'for': '10m',
          labels: {
            severity: '%(ReconciliationFailureSeverity)s' % $._config,
          },
          annotations: {
            summary: 'Reconciliation failure.',
            message: '{{ $labels.kind }} {{ $labels.namespace }}/{{ $labels.name }} reconciliation has been failing.',
          },
        },
      ],
    }],
  },
}
