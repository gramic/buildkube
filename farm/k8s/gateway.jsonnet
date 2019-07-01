{
  apiVersion: 'networking.istio.io/v1alpha3',
  kind: 'Gateway',
  metadata: {
    name: 'farm-gateway',
    namespace: 'farm',
  },
  spec: {
    selector: {
      istio: 'ingressgateway',
    },
    servers: [
      {
        hosts: [
          'farm.zoneprojects.com',
        ],
        port: {
          name: 'http',
          number: 80,
          protocol: 'HTTP',
        },
      },
    ],
  },
}
