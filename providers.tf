terraform {
  backend "azurerm" {
    resource_group_name  = "example-platform-tfstate"
    storage_account_name = "exampleplatformtfstate"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }

  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0.4.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

provider "azuread" {}
