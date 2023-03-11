output "aks_principal_id" {
  value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

output "kube_admin_config_host" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
}

output "kube_admin_config_client_cert" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_certificate
}

output "kube_admin_config_client_key" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_key
}

output "kube_admin_config_ca_cert" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate
}

output "kube_host" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
