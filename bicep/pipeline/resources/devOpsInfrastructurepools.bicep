param pools_devopspool_jsp_dev_001_name string = 'devopspool-jsp-dev-001'
param projects_devctrprj_jsp_dev_001_externalid string = '/subscriptions/6f224d82-ff8c-45ee-a61d-7fd2f93a73be/resourceGroups/NetworkWatcherRG/providers/Microsoft.DevCenter/projects/devctrprj-jsp-dev-001'

resource pools_devopspool_jsp_dev_001_name_resource 'Microsoft.DevOpsInfrastructure/pools@2025-01-21' = {
  name: pools_devopspool_jsp_dev_001_name
  location: 'eastus'
  properties: {
    provisioningState: 'Succeeded'
    organizationProfile: {
      organizations: [
        {
          url: 'https://dev.azure.com/jacobpack'
          projects: []
          parallelism: 1
          openAccess: true
        }
      ]
      permissionProfile: {
        kind: 'CreatorOnly'
      }
      kind: 'AzureDevOps'
    }
    devCenterProjectResourceId: projects_devctrprj_jsp_dev_001_externalid
    maximumConcurrency: 1
    agentProfile: {
      maxAgentLifetime: '7.00:00:00'
      gracePeriodTimeSpan: '00:00:00'
      kind: 'Stateful'
    }
    fabricProfile: {
      sku: {
        name: 'Standard_D2plds_v5'
      }
      images: [
        {
          resourceId: '/Subscriptions/6f224d82-ff8c-45ee-a61d-7fd2f93a73be/Providers/Microsoft.Compute/Locations/eastus/publishers/canonical/artifacttypes/vmimage/offers/0001-com-ubuntu-server-focal/skus/20_04-lts-arm64/versions/latest'
          buffer: '*'
        }
      ]
      osProfile: {
        secretsManagementSettings: {
          observedCertificates: []
          keyExportable: false
        }
        logonType: 'Interactive'
      }
      storageProfile: {
        osDiskStorageAccountType: 'Standard'
        dataDisks: []
      }
      kind: 'Vmss'
    }
  }
}
