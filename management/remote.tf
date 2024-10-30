# Get the platform (connectivity, management & core) configuration
# settings from outputs via the respective terraform
# remote state files

data "terraform_remote_state" "connectivity" {
  backend = "azurerm"

  config = {
    #  path = "${path.module}/../connectivity/connectivity.tfstate"
    resource_group_name  = "rg-dev-tfstate"
    storage_account_name = "stadevtfstate"
    container_name       = "atlz-dev-connectivity"
    key                  = "connectivity.tfstate"
  }
}

data "terraform_remote_state" "management" {
  #  backend = "local"
  backend = "azurerm"

  config = {
    #  path = "${path.module}/../management/management.tfstate"
    resource_group_name  = "rg-dev-tfstate"
    storage_account_name = "stadevtfstate"
    container_name       = "atlz-dev-management"
    key                  = "management.tfstate"
  }
}

data "terraform_remote_state" "core" {
  backend = "azurerm"

  config = {
    #  path = "${path.module}/../core/core.tfstate"
    resource_group_name  = "rg-dev-tfstate"
    storage_account_name = "stadevtfstate"
    container_name       = "atlz-dev-core"
    key                  = "core.tfstate"
  }
}
