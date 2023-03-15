resource "azurerm_key_vault_secret" "aks_admin_client_key" {
  name         = "${var.aks_name}-admin-client-key"
  value        = var.kube_config_client_key
  key_vault_id = var.key_vault_id
}
resource "azurerm_key_vault_secret" "aks_admin_client_certificate" {
  name         = "${var.aks_name}-admin-client-certificate"
  value        = var.kube_config_client_cert
  key_vault_id = var.key_vault_id
}
resource "azurerm_key_vault_secret" "aks_admin_cluster_ca_certificate" {
  name         = "${var.aks_name}-admin-cluster-ca-certificate"
  value        = var.kube_config_ca_cert
  key_vault_id = var.key_vault_id
}
