﻿#
# Module manifest for module 'module'
#
# Generated by: Arcus
#
# Generated on: 1/28/2021 10:42:46 AM
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'Arcus.Scripting.All.psm1'

# Version number of this module.
ModuleVersion = '#{Package.Version}#'

# ID used to uniquely identify this module
GUID = '4d5b8dc9-b4c0-4e9d-82f7-ac0bc009a898'

# Author of this module
Author = 'Arcus'

# Company or vendor of this module
CompanyName = ''

# Copyright statement for this module
Copyright = '(c) 2022 Arcus. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Scripts related to Azure'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(@{ModuleName='Arcus.Scripting.ApiManagement';ModuleVersion='#{Package.Version}#'},@{ModuleName='Arcus.Scripting.ARM';ModuleVersion='#{Package.Version}#'},@{ModuleName='Arcus.Scripting.DataFactory';ModuleVersion='#{Package.Version}#'},@{ModuleName='Arcus.Scripting.DevOps';ModuleVersion='#{Package.Version}#'},@{ModuleName='Arcus.Scripting.KeyVault';ModuleVersion='#{Package.Version}#'},@{ModuleName='Arcus.Scripting.LogicApps';ModuleVersion='#{Package.Version}#'},@{ModuleName='Arcus.Scripting.Security';ModuleVersion='#{Package.Version}#'},@{ModuleName='Arcus.Scripting.Sql';ModuleVersion='#{Package.Version}#'},@{ModuleName='Arcus.Scripting.Storage.All';ModuleVersion='#{Package.Version}#'})

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = @()

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Azure', 'Arcus'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/arcus-azure/arcus.scripting/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://scripting.arcus-azure.net/'

        # A URL to an icon representing this module.
        IconUri = 'https://raw.githubusercontent.com/arcus-azure/arcus/master/media/arcus.png'

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/arcus-azure/arcus.scripting/releases/tag/v#{Package.Version}#'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

