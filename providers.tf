terraform {
  backend "azurerm" {
    resource_group_name  = "example-platform-tfstate"
    storage_account_name = "exampleplatformtfstate"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}
