using 'main.bicep'

param environmentName = readEnvironmentVariable('AZURE_ENV_NAME', 'dev')
param resourceGroupName = readEnvironmentVariable('AZURE_RESOURCE_GROUP', '')
param location = readEnvironmentVariable('AZURE_LOCATION', 'eastus2')
param clusterResourceGroupName = readEnvironmentVariable('CLUSTER_RESOURCE_GROUP', '')
param principalId = readEnvironmentVariable('AZURE_PRINCIPAL_ID', '')
param keyVaultName = readEnvironmentVariable('AZURE_KEY_VAULT_NAME', '')
