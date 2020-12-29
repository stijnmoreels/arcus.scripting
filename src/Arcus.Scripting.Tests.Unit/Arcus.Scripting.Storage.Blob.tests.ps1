using module Az
Import-Module -Name $PSScriptRoot\..\Arcus.Scripting.Storage.Blob -DisableNameChecking

Describe "Arcus" {
    Context "Blob Storage" {
        InModuleScope Arcus.Scripting.Storage.Table {
            It "Upload the expected amount of files to an existing Azure Blob Storage" {
                # Arrange
                $targetFolderPath = "/ships"
                $containerName = "Shipping containers"
                $resourceId = "Unique shipping ID"
                $containerPermissions = "Container"
                $filePrefix = "prefix-"
                $files = @( [pscustomobject]@{ Name = "Container 1"; FullName = "/Container 1" }, [pscustomobject]@{ Name = "Container 2"; FullName = "/Container 2" })
                $resourceGroupName = "shipping"
                $storageAccountName = "shipping-storage"
                $azResource = [pscustomobject]@{ Name = $storageAccountName; ResourceGroupName = $resourceGroupName }
                $storageAccount = New-Object -TypeName Microsoft.Azure.Management.Storage.Models.StorageAccount
                $psStorageAccount = New-Object -TypeName Microsoft.Azure.Commands.Management.Storage.Models.PSStorageAccount -ArgumentList $storageAccount

                Mock Get-AzStorageAccount {
                    $ResourceGroupName | Should -Be $resourceGroupName
                    $Name | Should -Be $storageAccountName
                    return $psStorageAccount } -Verifiable
                Mock Get-AzStorageContainer {
                    $Context | Should -Be $psStorageAccount.Context
                    $Name | Shoud -Be $containerName } -Verifiable
                Mock New-AzStorageContainer { }
                Mock Get-ChildItem { 
                    $Path | Should -Be $targetFolderPath
                    return $files  } -Verifiable
                Mock Get-AzResource {
                    $ResourceId | Should -Be $resourceId
                    return $azResource } -Verifiable
                Mock Set-AzStorageBlobContent {
                    $File | Should -BeIn ($files | % { $_.FullName })
                    $Container | Should -Be $containerName
                    $Blob | Should -Be ($filePrefix + $File)
                    $Context | Should -Be $psStorageAccount.Context } -Verifiable

                # Act
                Upload-AzFilesToBlobStorage -TargetFolderPath $targetFolderPath -ContainerName $containerName -StorageAccountResourceId $resourceId -ContainerPermissions $containerPermissions -FilePrefix $filePrefix
                
                # Assert
                Assert-VerifiableMock
                Assert-MockCalled Get-AzStorageAccount -Times 1
                Assert-MockCalled Get-AzStorageContainer -Times 1
                Assert-MockCalled New-AzStorageContainer -Times 0
                Assert-MockCalled Get-ChildItem -Times 1
                Assert-MockCalled Get-AzResource -Times 1
                Assert-MockCalled Set-AzStorageBlobContent -Times 1
            }
            It "Upload the expected amount of files to a new Azure Blob Storage" {
                # Arrange
                $targetFolderPath = "/ships"
                $containerName = "Shipping containers"
                $resourceId = "Unique shipping ID"
                $containerPermissions = "Container"
                $filePrefix = "prefix-"
                $files = @( [pscustomobject]@{ Name = "Container 1" }, [pscustomobject]@{ Name = "Container 2" })
                $resourceGroupName = "shipping"
                $storageAccountName = "shipping-storage"
                $azResource = [pscustomobject]@{ Name = $storageAccountName; ResourceGroupName = $resourceGroupName }
                $storageAccount = New-Object -TypeName Microsoft.Azure.Management.Storage.Models.StorageAccount
                $psStorageAccount = New-Object -TypeName Microsoft.Azure.Commands.Management.Storage.Models.PSStorageAccount -ArgumentList $storageAccount

                Mock Get-AzStorageAccount {
                    $ResourceGroupName | Should -Be $resourceGroupName
                    $Name | Should -Be $storageAccountName
                    return $psStorageAccount } -Verifiable
                Mock Get-AzStorageContainer {
                    $Context | Should -Be $psStorageAccount.Context
                    $Name | Shoud -Be $containerName
                    throw "Sabotage getting an existing Azure Storage container" } -Verifiable
                Mock New-AzStorageContainer { 
                    $Context | Should -Be $psStorageAccount.Context
                    $Name | Should -Be $containerName
                    $Permission | Should -Be $containerPermissions }
                Mock Get-ChildItem { 
                    $Path | Should -Be $targetFolderPath
                    return $files  } -Verifiable
                Mock Get-AzResource {
                    $ResourceId | Should -Be $resourceId
                    return $azResource } -Verifiable
                 Mock Set-AzStorageBlobContent {
                    $File | Should -BeIn ($files | % { $_.FullName })
                    $Container | Should -Be $containerName
                    $Blob | Should -Be ($filePrefix + $File)
                    $Context | Should -Be $psStorageAccount.Context } -Verifiable

                # Act
                Upload-AzFilesToBlobStorage -TargetFolderPath $targetFolderPath -ContainerName $containerName -StorageAccountResourceId $resourceId -ContainerPermissions $containerPermissions -FilePrefix $filePrefix
                
                # Assert
                Assert-VerifiableMock
                Assert-MockCalled Get-AzStorageAccount -Times 1
                Assert-MockCalled Get-AzStorageContainer -Times 1
                Assert-MockCalled New-AzStorageContainer -Times 1
                Assert-MockCalled Get-ChildItem -Times 1
                Assert-MockCalled Get-AzResource -Times 1
                Assert-MockCalled Set-AzStorageBlobContent -Times 1
            }
        }
    }
}