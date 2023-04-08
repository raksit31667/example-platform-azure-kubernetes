terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0.4.0"
    }
  }
}

provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/raksitman"
  personal_access_token = var.ado_pat_secret
}
