metadata description = 'Creates an Azure Cosmos DB for MongoDB account with a database.'
param accountName string
param databaseName string
param location string = resourceGroup().location
param tags object = {}

param collections array = []
param connectionStringKey string = 'AZURE-COSMOS-CONNECTION-STRING'

module cosmos 'cosmos-mongo-account.bicep' = {
  name: 'cosmos-mongo-account'
  params: {
    name: accountName
    location: location
    tags: tags
  }
}

resource database 'Microsoft.DocumentDB/databaseAccounts/mongodbDatabases@2022-08-15' = {
  name: '${accountName}/${databaseName}'
  tags: tags
  properties: {
    resource: { id: databaseName }
  }

  resource list 'collections' = [for collection in collections: {
    name: collection.name
    properties: {
      resource: {
        id: collection.id
        shardKey: { _id: collection.shardKey }
        indexes: [ { key: { keys: [ collection.indexKey ] } } ]
      }
    }
  }]

  dependsOn: [
    cosmos
  ]
}

output connectionStringKey string = connectionStringKey
output accountName string = cosmos.outputs.name
output databaseName string = databaseName
output endpoint string = cosmos.outputs.endpoint
