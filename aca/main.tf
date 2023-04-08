resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "exampleplatformloganalytics"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "aca_environment" {
  name                       = "exampleplatformacaenvironment"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

resource "azurerm_user_assigned_identity" "aca_user_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name = "${azurerm_container_app_environment.aca_environment.name}-user-assigned-identity"
}

resource "azurerm_role_assignment" "aca_acr" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.aca_user_identity.principal_id
}

resource "azurerm_storage_account" "aca_terraform_storage_account" {
  name                     = "exampleplatformacatfstate"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  access_tier              = "Standard"
  account_replication_type = "LRS"
}
