//system vars
var envString = 'dev'
var systemName = 'jsp'
var orgName = 'orgName'
var primaryRegion = 'eastus2'

//subscription vars
var subscriptionWorkloadType = 'DevTest'
var subscriptionDefinition_OfferType = 'MS-AZR-0148P'
var deploySubscription bool = false

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

module jsp_Subscription './resources/subscription.bicep' = if (deploySubscription) {
  name: 'jsp_Subscription'
  scope: tenant()
  params: {
    envString: envString
    systemName: systemName
    orgName: orgName
    subscriptionDefinition_OfferType: subscriptionDefinition_OfferType
    workloadType: subscriptionWorkloadType
  }
}

module jsp_StorageAccount './resources/storageAccount.bicep' = {
  name: storageAccountName
  params: {
    storageAccountLocation: storageAccountLocation
    storageAccountKind: storageAccountKind
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSKU
  }
}

module jsp_Vnet './resources/vnet.bicep' = {
  name: vnetName
  params: {
    vnetName:vnetName
    vnetLocation:primaryRegion
    vnetEncryptionEnabled:vnetEncryptionEnabled
    vnetEncryptionEnforcement:vnetEncryptionEnforcement
    vnetPrivateVnetPolicies:vnetPrivateVnetPolicies
    vnetEnabledDdosProtection:vnetEnabledDdosProtection
  }
}
