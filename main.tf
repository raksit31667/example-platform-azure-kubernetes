resource "azurerm_resource_group" "resource_group" {
  location = "South East Asia"
  name     = "example-platform-azure-kubernetes"
}

resource "azurerm_resource_group" "resource_group_prod_au" {
  location = "Australia East"
  name     = "example-platform-aca-prod-au"
}

resource "azurerm_resource_group" "resource_group_prod_us" {
  location = "Central US"
  name     = "example-platform-aca-prod-us"
}

module "acr" {
  source              = "./acr"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

module "key_vault" {
  source              = "./keyvault"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  aks_name            = "exampleplatformaks"
}

# module "aks" {
#   source              = "./aks"
#   location            = azurerm_resource_group.resource_group.location
#   resource_group_name = azurerm_resource_group.resource_group.name
#   resource_group_id   = azurerm_resource_group.resource_group.id
#   aks_name            = "exampleplatformaks"
#   acr_id              = module.acr.acr_id
# }

module "aca" {
  source = "./aca"
  resource_groups = [
    {
      location            = azurerm_resource_group.resource_group.location
      resource_group_name = azurerm_resource_group.resource_group.name
      region_code         = "sg"
    },
    {
      location            = azurerm_resource_group.resource_group_prod_au.location
      resource_group_name = azurerm_resource_group.resource_group_prod_au.name
      region_code         = "au"
    },
    {
      location            = azurerm_resource_group.resource_group_prod_us.location
      resource_group_name = azurerm_resource_group.resource_group_prod_us.name
      region_code         = "us"
    }
  ]
  acr_id = module.acr.acr_id
}

module "ado" {
  source                = "./ado"
  ado_pat_secret        = var.ado_pat_secret
  resource_group_name   = azurerm_resource_group.resource_group.name
  acr_name              = module.acr.acr_name
  region_codes          = ["sg", "au", "us"]
  aca_environment_ids   = module.aca.aca_environment_ids
  aca_user_identity_ids = module.aca.aca_user_identity_ids
  # aks_name              = "exampleplatformaks"
  # aks_server_url        = module.aks.fqdn
}
