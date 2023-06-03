resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  for_each = {
    for rg in var.resource_groups : rg.region_code => rg
  }

  name                = "exampleplatformloganalytics${each.value.region_code}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "aca_environment" {
  for_each = {
    for rg in var.resource_groups : rg.region_code => rg
  }

  name                       = "exampleplatformacaenvironment${each.value.region_code}"
  location                   = each.value.location
  resource_group_name        = each.value.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace[each.value.region_code].id
}

resource "azurerm_user_assigned_identity" "aca_user_identity" {
  for_each = {
    for rg in var.resource_groups : rg.region_code => rg
  }

  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  name = "${azurerm_container_app_environment.aca_environment[each.value.region_code].name}-user-assigned-identity"
}

resource "azurerm_role_assignment" "aca_acr" {
  for_each = {
    for rg in var.resource_groups : rg.region_code => rg
  }
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.aca_user_identity[each.value.region_code].principal_id
}

resource "azurerm_storage_account" "aca_terraform_state_storage_account" {
  name                     = "exampleplatformacastate"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "aca_terraform_state_storage_container" {
  name                  = "terraform-state"
  storage_account_name  = azurerm_storage_account.aca_terraform_state_storage_account.name
  container_access_type = "container"
}
