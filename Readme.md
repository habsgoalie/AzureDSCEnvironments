## Azure DSC Environment setup scripts

This repo contains scripts to use foe setting up [Azure Automation Accounts for DSC](https://github.com/Azure/azure-content/blob/master/articles/automation/automation-dsc-overview.md) and [onboarding systems for management](https://github.com/Azure/azure-content/blob/master/articles/automation/automation-dsc-onboarding.md) via DSC.

In order to use these scripts, you need to install the AzureRM PowerShell module. If you have PowerShell 5 or later, you can install with the following commands:

```powershell
Install-Module AzureRm
Install-AzureRm
Import-AzureRm
```
### Setting up and Azure Automation account to manage a group of systems

Setting up an account in EA's Azure subscription is done by invoking [AzureAutomation-setup.ps1](../browse/SetupScripts/AzureAutomation-setup.ps1). Below are the parameters to supply.

#### AutomationAccountName (required)

This parameter is required. Provide a name that is descriptive of the server class or grouping that you will manage.

#### Credential (required)

A pscredential object for your Azure Ad identity you use to access and manage resources in the Azure subscription.

#### SubscriptionName (optional)

You can specify an Azure subscription to use.

#### Location (optional)

You can specify the Azure region in which you want to place your automation account.

#### Example:

```powershell 
.\AzureAutomation-setup.ps1 -AutomationAccountName "DomainControllers" -Credential "user@address.com"
```

This command will create an account called `DomainControllers` in your subscription, and specified region. When you run this a login window will appear to enter password.

### Joining an on premises server to an Azure automation DSC account

Joining an on premises machine to an Azure Automation DSC account can be done using the [AzureDscNode-setup.ps1](../browse/SetupScripts/AzureDscNode-setup.ps1) script.

The following parameters are used:

#### ResourceGroupName

Resource group the Automation account resides in. If you used the script above to set up your automation account, the resource group name will be the same as the account name.

#### AutomationAccountName

Automation account name.

#### AzureCredential

PS Credential object for the Azure AD account you use to access and manage resources in your Azure subscription.

#### LocalCredential

PS Credential object for either a local or domain account with admin rights to the node you are joining to the account.

#### ComputerName

The FQDN host name of the computer you are joining to the account.

#### Example:

```powershell
.\AzureDscNode-setup.ps1 -ComputerName "server01.domain.local" -AutomationaAccountName "DomainControllers" -ResourceGroupName "DomainControllers" -AzureCredential "kevin@domain.local" -LocalCredential "domain.local\kevin"
``` 