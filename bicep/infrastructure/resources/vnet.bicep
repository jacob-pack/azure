param vnetName string
param vnetLocation string
param vnetAddressPrefixes string
param vnetEncryptionEnabled bool
param vnetEncryptionEnforcement string
param vnetPrivateVnetPolicies string
param vnetEnabledDdosProtection bool

resource vnetResource 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetName
  location: vnetLocation
  properties: {
    addressSpace: {
      addressPrefixes: [vnetAddressPrefixes]
    }
    encryption: {
      enabled: vnetEncryptionEnabled
      enforcement: vnetEncryptionEnforcement
    }
    privateEndpointVNetPolicies: vnetPrivateVnetPolicies
    subnets: []
    virtualNetworkPeerings: []
    enableDdosProtection: vnetEnabledDdosProtection
  }
}
