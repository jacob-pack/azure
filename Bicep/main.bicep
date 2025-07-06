var envString = 'dev'
var systemName = 'JSP'
var orgName = 'orgName'

var storageAccountName = 'st${systemName}${envString}001'



module JSP_Subscription './Resources/Subscription.bicep' = {
  name: 'JSP_Subscription'
  scope: tenant()
  params:{}
}


module JSP_StorageAccount './Resources/StorageAccount.bicep'={
  name: storageAccountName
  params:{}


}


module JSP_AppService './Resources/AppService.bicep' ={
    name: 'JSP_AppService'
    params:{ 
    
    
  



  }
}
