param expressRouteCircuitName string
param expressRouteCircuitLocation string
param expressRouteCircuitSkuName string
param expressRouteCircuitSkuTier string
param expressRouteCircuitSkuFamily string
param expressRouteCircuitServiceProviderName string
param expressRouteCircuitPeeringLocation string
param expressRouteCircuitBandwidth int
param expressRouteCircuitAllowClassicOperations bool
param expressRouteCircuitGlobalReach bool
param expressRouteCircuitEnableDirectPortRateLimit bool


resource expressRouteCircuits_excir_jsp_eastus_001_name_resource 'Microsoft.Network/expressRouteCircuits@2024-05-01' = {
  name: expressRouteCircuitName
  location: expressRouteCircuitLocation
  sku: {
    name: expressRouteCircuitSkuName
    tier: expressRouteCircuitSkuTier
    family: expressRouteCircuitSkuFamily
  }
  properties: {
    peerings: []
    authorizations: []
    serviceProviderProperties: {
      serviceProviderName: expressRouteCircuitServiceProviderName
      peeringLocation: expressRouteCircuitPeeringLocation
      bandwidthInMbps: expressRouteCircuitBandwidth
    }
    circuitProvisioningState: 'Enabled'
    allowClassicOperations: expressRouteCircuitAllowClassicOperations
    serviceKey: '53d96a39-433e-4e4e-a830-6089d3f37a3c'
    serviceProviderProvisioningState: 'NotProvisioned'
    globalReachEnabled: expressRouteCircuitGlobalReach
    enableDirectPortRateLimit: expressRouteCircuitEnableDirectPortRateLimit
  }
}
