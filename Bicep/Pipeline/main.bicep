var envString = 'dev'
var systemName = 'JSP'
var orgName = 'orgName'



module JSP_DevOpsInfrastructurePools './Resources/DevOpsInfrastructurepools.bicep' = {
  name: 'JSP_DevOpsInfrastructurePools'
  params:{}
}

module JSP_DevOpsInfrastructurePools './Resources/Pipelines.bicep' = {
  name: 'JSP_Pipelines'
  params:{}
}

