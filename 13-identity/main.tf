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
    key                  = "13-identity.tfstate"
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
  #root_parent_id = data.azurerm_client_config.identity.tenant_id
  root_parent_id   = "atlzdev"
  root_id          = var.root_id
  root_name        = var.root_name
  library_path     = "${path.module}/lib"

  default_location = "westeurope"

  # Enable creation of the core management group hierarchy
  # and additional custom_landing_zones
  #deploy_core_landing_zones = true
  #custom_landing_zones      = local.custom_landing_zones
  deploy_identity_resources = true
  # Will Move these subscriptions needed by platform to associated management groups for each.
  subscription_id_identity     = data.terraform_remote_state.vending.outputs.subscription_id_identity
  subscription_id_management   = data.terraform_remote_state.vending.outputs.subscription_id_management
  subscription_id_connectivity = data.terraform_remote_state.vending.outputs.subscription_id_connectivity
}
