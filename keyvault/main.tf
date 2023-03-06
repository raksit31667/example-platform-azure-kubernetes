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

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_secret" "key_vault_aks_identity_service_principal_client_id" {
  name         = "${var.aks_name}-identity-service-principal-client-id"
  value        = azuread_application.secrets_akv_identity_app.application_id
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "aks_secrets_akv_password" {
  name         = "${var.aks_name}-identity-service-principal-client-password"
  value        = azuread_service_principal_password.secrets_akv_identity_spn_password.value
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
