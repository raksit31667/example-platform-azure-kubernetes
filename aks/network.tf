resource "azurerm_virtual_network" "network" {
  name                = "example-platform-network"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.254.0.0/16"]
}

resource "azurerm_subnet" "application_gateway_subnet" {
  name                 = "example-platform-application-gateway-subnet"
  virtual_network_name = azurerm_virtual_network.network.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.254.0.0/24"]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "example-platform-aks-subnet"
  virtual_network_name = azurerm_virtual_network.network.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.254.2.0/24"]

  service_endpoints = ["Microsoft.ContainerRegistry", "Microsoft.KeyVault"]
}
