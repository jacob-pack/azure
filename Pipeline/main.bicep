var envString = 'dev'
var systemName = 'JSP'
var orgName = 'orgName'

var storageAccountName = 'st${systemName}${envString}001'



module JSP_DevOpsInfrastructurePools './Resources/Subscription.bicep' = {
  name: 'JSP_DevOpsInfrastructurePools'
  scope: tenant()
  params:{}
}

