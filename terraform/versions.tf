terraform {
  required_version = ">= 1.16.0"
  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-mission90-tfstate"
    storage_account_name = "stmission90tfstate092026"
    container_name       = "tfstate"
    key                  = "mission90-dev.tfstate"
    use_azuread_auth     = true
  }
}
