var envString = 'dev'
var systemName = 'JSP'

var storageAccountName = 'st${systemName}${envString}-001'



module JSP_StorageAccount './Resources/StorageAccount.bicep'={
  name: storageAccountName
  params:{}


}


module JSP_AppService './Resources/AppService.bicep' ={
    name: 'JSP_AppService'
    params:{ 
    
    
  



  }
}
