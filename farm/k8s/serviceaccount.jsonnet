{
  apiVersion: 'v1',
  imagePullSecrets: [
    {
      name: 'image-pull-secret',
    },
  ],
  kind: 'ServiceAccount',
  metadata: {
    name: 'my-serviceaccount',
  },
}
