Param(
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$AutomationAccountName,
    
    [Parameter(Mandatory=$true)]
    [string]$ComputerName,
    
    [Parameter(Mandatory=$true)]
    [System.Management.Automation.CredentialAttribute()]
    $AzureCredential,
    
    [Parameter(Mandatory=$true)]
    [System.Management.Automation.CredentialAttribute()]
    $LocalCredential
)

Import-Module azure
Import-Module -Name AzureRM.Profile
Import-Module -Name AzureRM.Automation
Disable-AzureDataCollection

#Add-AzureAccount
Login-AzureRmAccount -Credential $AzureCredential

$Path = $env:TEMP

Get-AzureRmAutomationDscOnboardingMetaconfig -ResourceGroupName $ResourceGroupName -AutomationAccountName $AutomationAccountName `
-ComputerName $ComputerName -OutputFolder $Path -Force

#$MetaConfig = "$Path\DscMetaConfigs\$ComputerName.meta.mof"
#(Get-Content $MetaConfig) | foreach {$_ -replace "AllowModuleOverwrite = False;","AllowModuleOverwrite = True;"} | Set-Content $MetaConfig

Set-DscLocalConfigurationManager -Path "$Path\DscMetaConfigs" -ComputerName $ComputerName -Credential $LocalCredential
