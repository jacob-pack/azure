param projects_devctrprj_jsp_dev_001_name string = 'devctrprj-jsp-dev-001'
param devcenters_devctr_jsp_dev_001_externalid string = '/subscriptions/6f224d82-ff8c-45ee-a61d-7fd2f93a73be/resourceGroups/rg-jsp-devops-001/providers/Microsoft.DevCenter/devcenters/devctr-jsp-dev-001'

resource projects_devctrprj_jsp_dev_001_name_resource 'Microsoft.DevCenter/projects@2025-02-01' = {
  name: projects_devctrprj_jsp_dev_001_name
  location: 'eastus2'
  properties: {
    devCenterId: devcenters_devctr_jsp_dev_001_externalid
  }
}
