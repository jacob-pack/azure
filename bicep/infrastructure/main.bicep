//system vars
var envString = 'dev'
var systemName = 'jsp'
var orgName = 'orgName'
var primaryRegion = 'eastus2'

//normally, I construct the resource name in the resource file with the component vars above passed in.
//I have left them here in main, in this instance, for easy access/legiblity

//I would generally split up the driving files for various components (platform lzs, application lzs, network components, etc...)
//In this instance I am leaving it all here for simplicity.

//subscription vars
var subscriptionName = 'sub-${orgName}-${systemName}-${envString}-001'
var subscriptionDefName = 'subdef-${orgName}-${systemName}-${envString}-001'
var subscriptionWorkloadType = 'DevTest'
var subscriptionDefinition_OfferType = 'MS-AZR-0148P'
var deploySubscription bool = false

//resource group vars
var storageResourceGroup = 'rg-${systemName}-storage-${envString}-001'
var networkResourceGroup = 'rg-${systemName}-network-${envString}-001'
var devopsResourceGroup = 'rg-${systemName}-devops-${envString}-001'
var allResourceGroupNames array = [storageResourceGroup, networkResourceGroup, devopsResourceGroup]

//storage account vars
var storageAccountName = 'st${systemName}${envString}001'
var storageAccountLocation = primaryRegion
var storageAccountKind = 'StorageV2'
var storageAccountSKU = 'Standard_LRS'

//vnet vars
var vnetName = 'vnet-${systemName}-${primaryRegion}-001'
var vnetAddressPrefixes = '10.0.0.0/16'
var vnetEncryptionEnabled = true
var vnetEncryptionEnforcement = 'AllowUnencrypted'
var vnetPrivateVnetPolicies = 'Disabled'
var vnetEnabledDdosProtection = false

//express route circuit vars
var expressRouteCircuitName = 'excir-${systemName}-${primaryRegion}-001'
var expressRouteCircuitLocation = primaryRegion
var expressRouteCircuitSkuName = 'Standard_MeteredData'
var expressRouteCircuitSkuTier = 'Standard'
var expressRouteCircuitSkuFamily = 'MeteredData'
var expressRouteCircuitServiceProviderName = 'CenturyLink Cloud Connect' //now known as Lumen but still configured with this name
var expressRouteCircuitServicePeeringLocation = 'Atlanta'
var expressRouteCircuitServiceBandwidth = 50 //Mbps
var expressRouteCircuitAllowClassicOperations = false
var expressRouteCircuitGlobalReach = false
var expressRouteCircuitEnableDirectPortRateLimit = false

//I have left the variables in the main file, instead of abstracting them to a variables file, for simplicity.
//In a production environment the variables would produce too much clutter in main.

//In a production environment, I would generally separate Tenant/Subscription/ResourceGroup deployment workflows.
//For simplicities sake I target the scope at the module level here.


//------------------Platform Landing Zone---------------------------

module jsp_ExpressRouteCircuits './resources/expressRouteCircuits.bicep' = {
  name: expressRouteCircuitName
  scope: resourceGroup(networkResourceGroup)
  params: {
    expressRouteCircuitName: expressRouteCircuitName
    expressRouteCircuitLocation: expressRouteCircuitLocation
    expressRouteCircuitSkuName: expressRouteCircuitSkuName
    expressRouteCircuitSkuTier: expressRouteCircuitSkuTier
    expressRouteCircuitSkuFamily: expressRouteCircuitSkuFamily
    expressRouteCircuitServiceProviderName: expressRouteCircuitServiceProviderName
    expressRouteCircuitPeeringLocation: expressRouteCircuitServicePeeringLocation
    expressRouteCircuitBandwidth: expressRouteCircuitServiceBandwidth
    expressRouteCircuitAllowClassicOperations: expressRouteCircuitAllowClassicOperations
    expressRouteCircuitGlobalReach: expressRouteCircuitGlobalReach
    expressRouteCircuitEnableDirectPortRateLimit: expressRouteCircuitEnableDirectPortRateLimit
  }
}

//------------------Application Landing Zone---------------------------

module jsp_Subscription './resources/subscription.bicep' = if (deploySubscription) {
  name: 'jsp_Subscription'
  scope: tenant()
  params: {
    subscriptionName: subscriptionName
    subscriptionDefName: subscriptionDefName
    subscriptionDefinition_OfferType: subscriptionDefinition_OfferType
    workloadType: subscriptionWorkloadType
  }
}

module jsp_ResourceGroups './resources/resourceGroups.bicep' = [
  for resourceGroupName in allResourceGroupNames: {
    name: resourceGroupName
    scope: subscription(subscriptionName)
    params: {
      resourceGroupLocation: primaryRegion
      resourceGroupName: resourceGroupName
    }
  }
]

module jsp_Vnet './resources/vnet.bicep' = {
  name: vnetName
  scope: resourceGroup(networkResourceGroup)
  params: {
    vnetName: vnetName
    vnetLocation: primaryRegion
    vnetAddressPrefixes: vnetAddressPrefixes
    vnetEncryptionEnabled: vnetEncryptionEnabled
    vnetEncryptionEnforcement: vnetEncryptionEnforcement
    vnetPrivateVnetPolicies: vnetPrivateVnetPolicies
    vnetEnabledDdosProtection: vnetEnabledDdosProtection
  }
}



module jsp_StorageAccount './resources/storageAccount.bicep' = {
  name: storageAccountName
  scope: resourceGroup(storageResourceGroup)
  params: {
    storageAccountLocation: storageAccountLocation
    storageAccountKind: storageAccountKind
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSKU
  }
}

