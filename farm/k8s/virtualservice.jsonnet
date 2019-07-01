{
  apiVersion: 'networking.istio.io/v1alpha3',
  kind: 'VirtualService',
  metadata: {
    name: 'kubefarm-virtualservice',
    namespace: 'farm',
  },
  spec: {
    gateways: [
      'farm-gateway',
    ],
    hosts: [
      'farm.zoneprojects.com',
    ],
    http: [
      {
        route: [
          {
            destination: {
              host: 'buildfarm-server',
              port: {
                number: 80,
              },
            },
          },
        ],
      },
    ],
  },
}
