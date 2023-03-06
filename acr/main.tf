resource "azurerm_container_registry" "container_registry" {
  location            = var.location
  name                = "exampleplatformacr"
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azuread_application" "application_kubernetes" {
  display_name = "example-platfom-azure-kubernetes"
}

resource "azuread_application_password" "application_kubernetes_password" {
  application_object_id = azuread_application.application_kubernetes.object_id
}

resource "azuread_service_principal" "application_kubernetes_principal" {
  application_id = azuread_application.application_kubernetes.application_id
}
