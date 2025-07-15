//system vars
var envString = 'dev'
var systemName = 'jsp'
var orgName = 'orgName'
var primaryRegion = 'eastus2'

//normally, I construct the resource name in the resource file with the component vars above passed in.
//I have left them here in main, in this instance, for easy access/legiblity

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
var allResourceGroupNames array = [storageResourceGroup,networkResourceGroup,devopsResourceGroup]
//I could loop through the descriptor field (storage/network/devops/etc..._ but left these fully constructed for legibility.

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

//I have left the variables in the main file, instead of abstracting them to a variables file, for simplicity.

//In a production environment, I would generally separate Tenant/Subscription/ResourceGroup deployment workflows.
//For simplicities sake I target the scope at the module level here.

module jsp_Subscription './resources/subscription.bicep' = if (deploySubscription) {
  name: 'jsp_Subscription'
  scope: tenant()
  params: {
    subscriptionName:subscriptionName
    subscriptionDefName:subscriptionDefName
    subscriptionDefinition_OfferType: subscriptionDefinition_OfferType
    workloadType: subscriptionWorkloadType
  }
}


module jsp_ResourceGroups './resources/resourceGroups.bicep' = [for resourceGroupName in allResourceGroupNames: {
name: resourceGroupName
scope: subscription(subscriptionName)
params:{
  resourceGroupLocation:primaryRegion
  resourceGroupName: resourceGroupName
}
}]

module jsp_Vnet './resources/vnet.bicep' = {
  name: vnetName
  scope: resourceGroup(networkResourceGroup)
  params: {
    vnetName:vnetName
    vnetLocation:primaryRegion
    vnetAddressPrefixes:vnetAddressPrefixes
    vnetEncryptionEnabled:vnetEncryptionEnabled
    vnetEncryptionEnforcement:vnetEncryptionEnforcement
    vnetPrivateVnetPolicies:vnetPrivateVnetPolicies
    vnetEnabledDdosProtection:vnetEnabledDdosProtection
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


