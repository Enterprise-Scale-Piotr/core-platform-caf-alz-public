# Get the current client configuration from the AzureRM provider
data "azurerm_client_config" "identity" {}

# Get Subscription IDs from Vending Provisioning for Platform.
data "terraform_remote_state" "vending" {
  backend = "azurerm"
  config = {
    subscription_id      = "4b05673b-62ce-4723-99fa-c1030624561e"
    resource_group_name  = "rg-tfbackend-dev"
    storage_account_name = "statlztfstatedev"
    container_name       = "bootstrap"
    key                  = "01-vending-dev.tfstate"
  }
}
