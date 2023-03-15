resource "azurerm_resource_group" "resource_group" {
  location = "South East Asia"
  name     = "example-platform-azure-kubernetes"
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

module "aks" {
  source              = "./aks"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  resource_group_id   = azurerm_resource_group.resource_group.id
  aks_name            = "exampleplatformaks"
  key_vault_id        = module.key_vault.key_vault_id
  acr_id              = module.acr.acr_id
}

module "aks_secrets" {
  source                  = "./aks-secrets"
  key_vault_id            = module.key_vault.key_vault_id
  aks_name                = "exampleplatformaks"
  kube_config_client_cert = module.aks.kube_config_client_cert
  kube_config_client_key  = module.aks.kube_config_client_key
  kube_config_ca_cert     = module.aks.kube_config_ca_cert
  kube_config             = module.aks.kube_config
}
