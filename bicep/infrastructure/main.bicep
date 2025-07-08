var envString = 'dev'
var systemName = 'jsp'
var orgName = 'orgName'
var subscriptionWorkloadType = 'DevTest'
var subscriptionDefinition_OfferType = 'MS-AZR-0148P'
var deploySubscription bool = false
var storageAccountName = 'st${systemName}${envString}001'



module jsp_Subscription './resources/subscription.bicep' = if (deploySubscription) {
  name: 'jsp_Subscription'
  scope: tenant()
  params:{
    envString: envString
    systemName: systemName
    orgName: orgName
    subscriptionDefinition_OfferType: subscriptionDefinition_OfferType
    workloadType: subscriptionWorkloadType
  }
}


module jsp_StorageAccount './resources/storageAccount.bicep'={
  name: storageAccountName
  params:{}


}
