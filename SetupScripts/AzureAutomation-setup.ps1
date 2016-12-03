Param(
    [Parameter(Mandatory=$true)]
    [string]$AutomationAccountName,
    
    [Parameter(Mandatory=$false)]
    [string]$SubscriptionName,
    
    [Parameter(Mandatory=$false)]
    [string]$Location,
    
    [Parameter(Mandatory=$true)]
    [System.Management.Automation.CredentialAttribute()]
    $Credential
)

Login-AzureRmAccount -Credential $Credential
Get-AzureRmSubscription -SubscriptionName $SubscriptionName | Select-AzureRmSubscription
New-AzureRmResourceGroup -Name $AutomationAccountName -Location $Location
New-AzureRmAutomationAccount -Name $AutomationAccountName -Location $Location -ResourceGroupName $AutomationAccountName