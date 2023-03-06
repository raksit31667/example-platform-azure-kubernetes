data "azuread_client_config" "current_client" {}

data "azurerm_client_config" "current" {}

resource "azuread_application" "aks_identity_application" {
  display_name = "${var.aks_name}-identity-application"
}

resource "azuread_service_principal" "aks_identity_service_principal" {
  application_id = azuread_application.aks_identity_application.application_id
  owners         = [data.azuread_client_config.current_client.object_id]
}

resource "azuread_service_principal_password" "aks_identity_service_principal_password" {
  service_principal_id = azuread_service_principal.aks_identity_service_principal.id
}

resource "azurerm_key_vault" "key_vault" {
  name                        = "exampleplatformkeyvault"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "aks_identity_service_principal_access_policy" {
  key_vault_id            = azurerm_key_vault.key_vault.id
  object_id               = azuread_service_principal.aks_identity_service_principal.object_id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  secret_permissions      = ["Get"]
  certificate_permissions = ["Get"]
  key_permissions         = ["Get"]
}

resource "azurerm_key_vault_access_policy" "current_service_principal_access_policy" {
  key_vault_id            = azurerm_key_vault.key_vault.id
  object_id               = data.azurerm_client_config.current.service_principal_object_id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  secret_permissions      = ["Get"]
  certificate_permissions = ["Get"]
  key_permissions         = ["Get"]
}

resource "azurerm_key_vault_secret" "key_vault_aks_identity_service_principal_client_id" {
  name         = "${var.aks_name}-identity-service-principal-client-id"
  value        = azuread_application.aks_identity_application.application_id
  key_vault_id = azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "key_vault_aks_identity_service_principal_client_password" {
  name         = "${var.aks_name}-identity-service-principal-client-password"
  value        = azuread_service_principal_password.aks_identity_service_principal_password.value
  key_vault_id = azurerm_key_vault.key_vault.id
}
