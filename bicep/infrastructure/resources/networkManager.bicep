param name string = 'netmgr-jsp-001'
param vnetId string = '/subscriptions/6f224d82-ff8c-45ee-a61d-7fd2f93a73be/resourceGroups/rg-jsp-network-001/providers/Microsoft.Network/virtualNetworks/vnet-jsp-eastus2-001'
param subscriptionId string


resource networkManager 'Microsoft.Network/networkManagers@2024-05-01' = {
  name: name
  location: 'eastus2'
  properties: {
    networkManagerScopes: {
      managementGroups: []
      subscriptions: [
        subscriptionId
      ]
    }
    networkManagerScopeAccesses: [
      'Connectivity'
      'SecurityAdmin'
      'Routing'
    ]
  }
}

resource networkManagerNetworkGroups 'Microsoft.Network/networkManagers/networkGroups@2024-05-01' = {
  parent: networkManager
  name: 'netgrp-jsp-001'
  properties: {
    memberType: 'VirtualNetwork'
  }
}

resource networkManagerConnectivityConfigurations 'Microsoft.Network/networkManagers/connectivityConfigurations@2024-05-01' = {
  parent: networkManager
  name: 'connconfig-jsp-eastus2-001'
  properties: {
    connectivityTopology: 'HubAndSpoke'
    hubs: [
      {
        resourceType: 'Microsoft.Network/virtualNetworks'
        resourceId: vnetId
      }
    ]
    appliesToGroups: [
      {
        networkGroupId: networkManager.id
        groupConnectivity: 'None'
        useHubGateway: 'False'
        isGlobal: 'False'
      }
    ]
    deleteExistingPeering: 'False'
    isGlobal: 'False'
  }
}
