# Configure Terraform to set the required AzureRM provider
# version and features{} block

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107.0"
    }
  }
  #  backend "local" {
  #    path = "./management.tfstate"
  #  }
  backend "azurerm" {
    tenant_id            = "e061f8b7-caf3-45f2-a8bc-491cea9e64aa"
    subscription_id      = "004b5dd3-9bf5-49d6-9236-f01d6b533dea" #management subscription id for remote tfstate blob
    resource_group_name  = "rg-platform-tfstate"
    storage_account_name = "staplatformtfstate"
    container_name       = "platform-tfstate"
    key                  = "management.tfstate"
  }
}

# Define the provider configuration

provider "azurerm" {
  features {}
  #subscription_id = var.subscription_id_management
}

# Get the current client configuration from the AzureRM provider

data "azurerm_client_config" "current" {}

# Declare the Azure landing zones Terraform module
# and provide the connectivity configuration.

module "alz" {
  # To enable correct testing of our examples, we must source this
  # module locally. Please remove the local `source = "../../../"`
  # and uncomment the remote `source` and `version` below.
  # source = "../../../"
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "6.1.0"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  # Base module configuration settings
  root_parent_id   = data.azurerm_client_config.current.tenant_id
  root_id          = var.root_id
  default_location = "westeurope"

  # Disable creation of the core management group hierarchy
  # as this is being created by the core module instance
  deploy_core_landing_zones = false

  # Configuration settings for management resources
  deploy_management_resources    = true
  configure_management_resources = local.configure_management_resources
  subscription_id_management     = var.subscription_id_management

}