param resourceGroupLocation string
param resourceGroupName string

targetScope = 'subscription'

resource resourceGroups 'Microsoft.Resources/resourceGroups@2025-04-01'= {
  name: resourceGroupName
  location: resourceGroupLocation
  properties:{}
}
