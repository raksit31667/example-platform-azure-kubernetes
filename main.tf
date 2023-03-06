resource "azurerm_resource_group" "resource_group" {
  location = "South East Asia"
  name     = "example-platform-azure-kubernetes"
}

module "acr" {
  source              = "./acr"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

module "key_vault" {
  source              = "./keyvault"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  aks_name            = "exampleplatformaks"
}
