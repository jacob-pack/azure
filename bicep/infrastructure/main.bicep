var envString = 'dev'
var systemName = 'JSP'
var orgName = 'orgName'
var subscriptionWorkloadType = 'DevTest'
var subscriptionDefinition_OfferType = 'MS-AZR-0148P'

var storageAccountName = 'st${systemName}${envString}001'



module JSP_Subscription './Resources/subscription.bicep' = {
  name: 'JSP_Subscription'
  scope: tenant()
  params:{
    envString: envString
    systemName: systemName
    orgName: orgName
    subscriptionDefinition_OfferType: subscriptionDefinition_OfferType
    workloadType: subscriptionWorkloadType
  }
}


module JSP_StorageAccount './Resources/storageAccount.bicep'={
  name: storageAccountName
  params:{}


}


module JSP_AppService './Resources/appService.bicep' ={
    name: 'JSP_AppService'
    params:{ 
    
    
  



  }
}
