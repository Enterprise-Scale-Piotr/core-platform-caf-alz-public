terraform {
  required_version = "1.8.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107.0"
    }
  }
  backend "azurerm" {
    subscription_id      = "4b05673b-62ce-4723-99fa-c1030624561e"
    resource_group_name  = "rg-tfbackend-dev"
    storage_account_name = "statlztfstatedev"
    container_name       = "platform"
    key                  = "12-management.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "plz" {
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
  subscription_id_management     = data.terraform_remote_state.vending.outputs.subscription_id_management
}
