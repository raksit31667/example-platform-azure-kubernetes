output "aca_environment_ids" {
  value = {
    for rg in var.resource_groups : rg.region_code => azurerm_container_app_environment.aca_environment[rg.region_code].id
  }
}

output "aca_user_identity_ids" {
  value = {
    for rg in var.resource_groups : rg.region_code => azurerm_user_assigned_identity.aca_user_identity[rg.region_code].id
  }
}
