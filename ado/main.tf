data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current_subscription" {}

data "azuredevops_project" "project" {
  name = "example-platform-azure-kubernetes"
}

resource "azuredevops_variable_group" "exampleplatformaca" {
  for_each = var.region_codes

  project_id   = data.azuredevops_project.project.id
  name         = "exampleplatformaca${each.value}"
  description  = "Variable group for ACA ${upper(each.value)}"
  allow_access = true

  variable {
    name  = "acaEnvironmentId"
    value = var.aca_environment_ids[each.value]
  }

  variable {
    name  = "acaUserIdentityId"
    value = var.aca_user_identity_ids[each.value]
  }
}

resource "azuredevops_serviceendpoint_azurecr" "exampleplatformacr" {
  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = var.acr_name
  resource_group            = var.resource_group_name
  azurecr_spn_tenantid      = data.azurerm_client_config.current.tenant_id
  azurecr_name              = var.acr_name
  azurecr_subscription_id   = data.azurerm_subscription.current_subscription.subscription_id
  azurecr_subscription_name = data.azurerm_subscription.current_subscription.display_name
}
