// Define the location for the deployment of the components.
param location string

// Define the name of the storage account that will be created.
param storageAccountName string

// Define the name of the Azure Functions app service that will be created.
param appServiceName string

// Define the name of the Azure SQL server instance that will be created.
param sqlServerName string

// Define the username of the administrator login for the Azure SQL server instance.
param sqlAdminUserName string

// Define the password of the administrator login for the Azure SQL server instance.
@secure()
param sqlAdminPassword string

// Define the Azure Key vault secret name of the administrator login password for the Azure SQL server instance.
param sqlAdminPassword_secretName string

// Define the name of the Azure SQL database that will be created within the Azure SQL server instance.
param sqlDatabaseName string

// Define the name of the integration account that will be created.
param integrationAccountName string

// Define the name of the Key Vault.
param keyVaultName string

// Define the Service Principal ID that needs access full access to the deployed resource group.
param servicePrincipal_objectId string

module storageAccount 'br/public:avm/res/storage/storage-account:0.9.1' = {
  name: 'storageAccountDeployment'
  params: {
    name: storageAccountName
    location: location
    allowBlobPublicAccess: true
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      virtualNetworkRules: []
    }
    roleAssignments: [
      {
        principalId: servicePrincipal_objectId
        roleDefinitionIdOrName: 'Storage Blob Data Contributor'
      }
      {
        principalId: servicePrincipal_objectId
        roleDefinitionIdOrName: 'Storage Table Data Contributor'
      }
    ]
  }
}

module serverfarm 'br/public:avm/res/web/serverfarm:0.2.2' = {
  name: 'serverfarmDeployment'
  params: {
    name: '${appServiceName}-plan'
    skuCapacity: 2
    skuName: 'Y1'
    location: location
  }
}

module functionApp 'br/public:avm/res/web/site:0.3.9' = {
  name: 'functionAppDeployment'
  params: {
    kind: 'functionapp'
    name: appServiceName
    serverFarmResourceId: serverfarm.outputs.resourceId
    location: location
    enableTelemetry: false
    siteConfig: {
      alwaysOn: false
    }
  }
}

module sqlServer 'br/public:avm/res/sql/server:0.4.1' = {
  name: 'sqlServerDeployment'
  params: {
    name: sqlServerName
    location: location
    administratorLogin: sqlAdminUserName
    administratorLoginPassword: sqlAdminPassword
    enableTelemetry: false
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    auditSettings: {
      state: 'Disabled'
    }
    databases: [
      {
        name: sqlDatabaseName
        skuName: 'GP_S_Gen5'
        skuTier: 'GeneralPurpose'
        skuCapacity: 1
        minCapacity: 1
      }
    ]
  }
}

resource integrationAccount 'Microsoft.Logic/integrationAccounts@2019-05-01' = {
  name: integrationAccountName
  location: location
  properties: {
    state: 'Enabled'
  }
  sku: {
    name: 'Free'
  }
}

module vault 'br/public:avm/res/key-vault/vault:0.6.1' = {
  name: 'vaultDeployment'
  params: {
    name: keyVaultName
    location: location
    roleAssignments: [
      {
        principalId: servicePrincipal_objectId
        roleDefinitionIdOrName: 'Key Vault Secrets officer'
      }
    ]
    secrets: [
      {
        name: sqlAdminPassword_secretName
        value: sqlAdminPassword
      }
    ]
  }
}