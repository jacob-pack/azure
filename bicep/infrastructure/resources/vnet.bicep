param virtualNetworks_vnet_jsp_eastus2_001_name string = 'vnet-jsp-eastus2-001'

resource virtualNetworks_vnet_jsp_eastus2_001_name_resource 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: virtualNetworks_vnet_jsp_eastus2_001_name
  location: 'eastus2'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: true
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: []
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}
