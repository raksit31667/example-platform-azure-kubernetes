resource "azurerm_public_ip" "aks_nat_gateway_public_ip" {
  name                = "example-platform-nat-gateway-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_nat_gateway" "aks_nat_gateway" {
  name                    = "example-platform-nat-gateway"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}

resource "azurerm_nat_gateway_public_ip_association" "aks_nat_gateway_public_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.aks_nat_gateway.id
  public_ip_address_id = azurerm_public_ip.aks_nat_gateway_public_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "aks_nat_gateway_subnet_association" {
  nat_gateway_id = azurerm_nat_gateway.aks_nat_gateway.id
  subnet_id      = azurerm_subnet.aks_subnet.id
}
