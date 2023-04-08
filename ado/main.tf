data "azuredevops_project" "project" {
  name = "example-platform-azure-kubernetes"
}

resource "azuredevops_variable_group" "exampleplatformaca" {
  project_id   = azuredevops_project.project.id
  name         = "exampleplatformaca"
  description  = "Variable group for ACA"
  allow_access = true

  variable {
    name  = "acaEnvironmentId"
    value = var.aca_environment_id
  }

  variable {
    name  = "acaUserIdentityId"
    value = var.aca_user_identity_id
  }
}
