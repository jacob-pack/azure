param storageAccountSku string
param storageAccountKind string
param storageAccountLocation string
param storageAccountName string

resource jspStorageAccount 'Microsoft.Storage/storageAccounts@2025-01-01' = {

  kind: storageAccountKind
  location: storageAccountLocation
  name: storageAccountName
  sku: {name: storageAccountSku} //sku expects a sku object

}
