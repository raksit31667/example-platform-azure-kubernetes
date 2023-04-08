output "aca_environment_id" {
  value = azurerm_container_app_environment.aca_environment.id
}

output "aca_user_identity_id" {
  value = azurerm_user_assigned_identity.aca_user_identity.id
}
