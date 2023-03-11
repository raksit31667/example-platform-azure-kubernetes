output "aks_principal_id" {
  value = length(azurerm_kubernetes_cluster.aks.identity) > 0 ? azurerm_kubernetes_cluster.aks.identity[0].principal_id : ""
}

output "kube_admin_config_host" {
  value = length(azurerm_kubernetes_cluster.aks.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.aks.kube_admin_config[0].host : ""
}

output "kube_admin_config_client_cert" {
  value = length(azurerm_kubernetes_cluster.aks.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_certificate : ""
}

output "kube_admin_config_client_key" {
  value = length(azurerm_kubernetes_cluster.aks.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_key : ""
}

output "kube_admin_config_ca_cert" {
  value = length(azurerm_kubernetes_cluster.aks.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate : ""
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
