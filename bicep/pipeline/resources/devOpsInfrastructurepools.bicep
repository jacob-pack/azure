resource symbolicname 'Microsoft.DevOpsInfrastructure/pools@2025-01-21' = {
  identity: {
    type: 'string'
    userAssignedIdentities: {
      {customized property}: {}
    }
  }
  location: 'string'
  name: 'string'
  properties: {
    agentProfile: {
      resourcePredictions: any(...)
      resourcePredictionsProfile: {
        kind: 'string'
        // For remaining properties, see ResourcePredictionsProfile objects
      }
      kind: 'string'
      // For remaining properties, see AgentProfile objects
    }
    devCenterProjectResourceId: 'string'
    fabricProfile: {
      kind: 'string'
      // For remaining properties, see FabricProfile objects
    }
    maximumConcurrency: int
    organizationProfile: {
      kind: 'string'
      // For remaining properties, see OrganizationProfile objects
    }
    provisioningState: 'string'
  }
  tags: {
    {customized property}: 'string'
  }
}
