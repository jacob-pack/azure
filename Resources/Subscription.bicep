var envString = 'dev'
var systemName = 'JSP'
var orgName = 'orgName'

var subscriptionName = 'sub-${orgName}-${systemName}-${envString}-001'


resource subscriptionName 'Microsoft.Subscription/aliases@2024-08-01-preview' = {
  name: subscriptionName
  properties: {
    additionalProperties: {
      managementGroupId: 'string'
      subscriptionOwnerId: 'string'
      subscriptionTenantId: 'string'
      tags: {
        {customized property}: 'string'
      }
    }
    billingScope: 'string'
    displayName: 'string'
    resellerId: 'string'
    subscriptionId: 'string'
    workload: 'string'
  }
}