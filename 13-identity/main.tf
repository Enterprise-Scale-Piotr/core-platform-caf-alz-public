# Configure Terraform to set the required AzureRM provider
# version and features{} block.

terraform {
  required_version = "1.8.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107.0"
    }
  }
  #  backend "local" {
  #    path = "./core.tfstate"
  #  }
  backend "azurerm" {
    tenant_id            = "e061f8b7-caf3-45f2-a8bc-491cea9e64aa"
    subscription_id      = "004b5dd3-9bf5-49d6-9236-f01d6b533dea" #management subscription id for remote tfstate blob
    resource_group_name  = "rg-platform-tfstate"
    storage_account_name = "staplatformtfstate"
    container_name       = "platform-tfstate"
    key                  = "identity.tfstate"
  }
}

# Define the provider configuration

provider "azurerm" {
  features {}
}

# Get the current client configuration from the AzureRM provider.

data "azurerm_client_config" "current" {}

# Declare the Azure landing zones Terraform module
# and provide the core configuration.

module "cafes" {
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
  root_name        = var.root_name
  library_path     = "${path.module}/lib"
  default_location = "westeurope"

  # Enable creation of the core management group hierarchy
  # and additional custom_landing_zones
  #deploy_core_landing_zones = true
  #custom_landing_zones      = local.custom_landing_zones

  # Configuration settings for identity resources is
  # bundled with core as no resources are actually created
  # for the identity subscription
  deploy_identity_resources    = true
  configure_identity_resources = local.configure_identity_resources
  subscription_id_identity     = var.subscription_id_identity

  # The following inputs ensure that managed parameters are
  # configured correctly for policies relating to connectivity
  # resources created by the connectivity module instance and
  # to map the subscription to the correct management group,
  # but no resources are created by this module instance
  deploy_connectivity_resources = false
  #configure_connectivity_resources = data.terraform_remote_state.connectivity.outputs.configuration
  #subscription_id_connectivity     = data.terraform_remote_state.connectivity.outputs.subscription_id_connectivity

  # The following inputs ensure that managed parameters are
  # configured correctly for policies relating to management
  # resources created by the management module instance and
  # to map the subscription to the correct management group,
  # but no resources are created by this module instance
  deploy_management_resources    = false
  configure_management_resources = data.terraform_remote_state.management.outputs.configuration
  subscription_id_management     = data.terraform_remote_state.management.outputs.subscription_id

}
