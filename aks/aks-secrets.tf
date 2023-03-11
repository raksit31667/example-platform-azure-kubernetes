resource "azurerm_key_vault_secret" "aks_admin_client_key" {
  name         = "${azurerm_kubernetes_cluster.aks.name}-admin-client-key"
  value        = length(azurerm_kubernetes_cluster.aks.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.aks.kube_admin_config.0.client_key : ""
  key_vault_id = var.key_vault_id
}
resource "azurerm_key_vault_secret" "aks_admin_client_certificate" {
  name         = "${azurerm_kubernetes_cluster.aks.name}-admin-client-certificate"
  value        = length(azurerm_kubernetes_cluster.aks.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.aks.kube_admin_config.0.client_certificate : ""
  key_vault_id = var.key_vault_id
}
resource "azurerm_key_vault_secret" "aks_admin_cluster_ca_certificate" {
  name         = "${azurerm_kubernetes_cluster.aks.name}-admin-cluster-ca-certificate"
  value        = length(azurerm_kubernetes_cluster.aks.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.aks.kube_admin_config.0.cluster_ca_certificate : ""
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "aks_admin_username" {
  name         = "${azurerm_kubernetes_cluster.aks.name}-admin-username"
  value        = length(azurerm_kubernetes_cluster.aks.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.aks.kube_admin_config.0.username : ""
  key_vault_id = var.key_vault_id
}
resource "azurerm_key_vault_secret" "aks_admin_password" {
  name         = "${azurerm_kubernetes_cluster.aks.name}-admin-password"
  value        = length(azurerm_kubernetes_cluster.aks.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.aks.kube_admin_config.0.password : ""
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "aks_service_principal_id" {
  name         = "${azurerm_kubernetes_cluster.aks.name}-service-principal-id"
  value        = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "aks_kubelet_identity_client_id" {
  name         = "${azurerm_kubernetes_cluster.aks.name}-kubelet-identity-client-id"
  value        = azurerm_kubernetes_cluster.aks.kubelet_identity[0].client_id
  key_vault_id = var.key_vault_id
}
resource "azurerm_key_vault_secret" "aks_host" {
  name         = "${azurerm_kubernetes_cluster.aks.name}-host"
  value        = azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
  key_vault_id = var.key_vault_id
}
