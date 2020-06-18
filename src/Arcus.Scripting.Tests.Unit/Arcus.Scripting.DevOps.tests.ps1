﻿Import-Module -Name $PSScriptRoot\..\Arcus.Scripting.DevOps -ErrorAction Stop

Describe "Arcus" {
	Context "Azure DevOps" {
		It "Set-DevOpsVariable" {
			# Arrange
			Mock Write-Host { $Object | Should -Match "#vso[task.setvariable variable=test] value" } -Verifiable

			# Act
			Set-DevOpsVariable "test" "value"

			# Assert
			Assert-VerifiableMocks
		}
	}
}