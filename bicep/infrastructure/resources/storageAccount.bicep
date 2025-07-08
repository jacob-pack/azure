param storageSku string = 'Standard_LRS'





resource jspStorageAccount 'Microsoft.Storage/storageAccounts@2025-01-01' = {

  kind: 'StorageV2'
  location: 'eastus2'
  name: 'stjspdev001'
  sku: {name: storageSku} //sku expects a sku object

}
