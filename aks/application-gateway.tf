locals {
  backend_address_pool_name              = "${azurerm_virtual_network.network.name}-beap"
  frontend_port_name                     = "${azurerm_virtual_network.network.name}-feport"
  frontend_public_ip_configuration_name  = "${azurerm_virtual_network.network.name}-feip"
  frontend_private_ip_configuration_name = "${azurerm_virtual_network.network.name}-feippri"
  http_setting_name                      = "${azurerm_virtual_network.network.name}-be-htst"
  listener_name                          = "${azurerm_virtual_network.network.name}-httplstn"
  request_routing_rule_name              = "${azurerm_virtual_network.network.name}-rqrt"
}

resource "azurerm_public_ip" "aks_application_gateway_public_ip" {
  name                = "example-platform-application-gateway-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_application_gateway" "aks_application_gateway" {
  name                = "example-platform-application-gateway"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
    capacity = 2
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.agw_user_identity.id]
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.application_gateway_subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_public_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.aks_application_gateway_public_ip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_public_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority = 1
  }
}
