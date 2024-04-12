{
  prometheusAlerts+:: {
    groups+: [{
      name: 'ingress-controller',
      rules: [
        {
          alert: 'NGINXConfigFailed',
          expr: 'count(nginx_ingress_controller_config_last_reload_successful == 0) > 0',
          'for': '10m',
          labels: {
            severity: '%(NGINXConfigFailedSeverity)s' % $._config,
          },
          annotations: {
            summary: 'Nginx reload configuration failed.',
            message: 'Bad Ingress configuration. Nginx configuration test failed.',
          },
        },
        {
          alert: 'NGINXTooMany500s',
          expr: '100 * ( sum( nginx_ingress_controller_requests{status=~"5.+"} ) / sum(nginx_ingress_controller_requests) ) > 5',
          'for': '10m',
          labels: {
            severity: '%(NGINXTooMany500sSeverity)s' % $._config,
          },
          annotations: {
            summary: 'Too many 5XXs.',
            message: 'More than 5% of all requests returned 5XX, this requires your attention.',
          },
        },
        {
          alert: 'NGINXTooMany400s',
          expr: '100 * ( sum( nginx_ingress_controller_requests{status=~"4.+"} ) / sum(nginx_ingress_controller_requests) ) > 5',
          'for': '10m',
          labels: {
            severity: '%(NGINXTooMany400sSeverity)s' % $._config,
          },
          annotations: {
            summary: 'Too many 4XXs.',
            message: 'More than 5% of all requests returned 4XX, this requires your attention.',
          },
        },
      ],
    }],
  },
}
