var envString = 'dev'
var systemName = 'JSP'
var orgName = 'orgName'
var subscriptionName = 'sub-${orgName}-${systemName}-${envString}-001'
var subscriptionDefName = 'subdef-${orgName}-${systemName}-${envString}-001'
var workloadType = 'DevTest'
var subscriptionDefinition_OfferType = 'MS-AZR-0148P'

targetScope = 'tenant'

resource subscriptionAlias_resource 'Microsoft.Subscription/aliases@2024-08-01-preview' = {
  name: subscriptionName
  properties: {
    workload: workloadType
  }
}

resource subscriptionDefinition_resource 'Microsoft.Subscription/subscriptionDefinitions@2017-11-01-preview' = {
  name: subscriptionDefName
  properties: {
    offerType: subscriptionDefinition_OfferType
    subscriptionDisplayName: subscriptionName
  }
}

//sub operations returns a list of operations that can be performed against the subscription
//the results include: display (obj that represents the operation), isDataAction, and name
//I have no use for it at this moment but suspect it would be useful later.
//resource subscriptionOperations_resource 'Microsoft.Subscription/subscriptionOperations@2017-11-01-preview' existing = {
//  name: subscriptionOperationsName
//}
