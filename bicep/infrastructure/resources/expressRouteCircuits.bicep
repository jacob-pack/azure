param expressRouteCircuits_excir_jsp_eastus_001_name string = 'excir-jsp-eastus-001'

resource expressRouteCircuits_excir_jsp_eastus_001_name_resource 'Microsoft.Network/expressRouteCircuits@2024-05-01' = {
  name: expressRouteCircuits_excir_jsp_eastus_001_name
  location: 'eastus'
  sku: {
    name: 'Standard_MeteredData'
    tier: 'Standard'
    family: 'MeteredData'
  }
  properties: {
    peerings: []
    authorizations: []
    serviceProviderProperties: {
      serviceProviderName: 'CenturyLink Cloud Connect'
      peeringLocation: 'Atlanta'
      bandwidthInMbps: 50
    }
    circuitProvisioningState: 'Enabled'
    allowClassicOperations: false
    serviceKey: '53d96a39-433e-4e4e-a830-6089d3f37a3c'
    serviceProviderProvisioningState: 'NotProvisioned'
    globalReachEnabled: false
    enableDirectPortRateLimit: false
  }
}
