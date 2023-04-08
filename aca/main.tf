resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "exampleplatformloganalytics"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Free"
  retention_in_days   = 7
}

resource "azurerm_container_app_environment" "aca_environment" {
  name                       = "exampleplatformacaenvironment"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}
