data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "${var.aks_name}-ssh-public-key"
  key_vault_id = var.key_vault_id
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                             = var.aks_name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  dns_prefix                       = "aks"
  kubernetes_version               = var.kubenetes_version
  sku_tier                         = "Free"
  http_application_routing_enabled = false
  azure_policy_enabled             = true

  linux_profile {
    admin_username = "raksit31667"

    ssh_key {
      key_data = file("${path.module}/id_rsa-aks.pub")
    }
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "userAssignedNATGateway"
    nat_gateway_profile {
      idle_timeout_in_minutes = 4
    }
  }

  default_node_pool {
    name                 = "agentpool"
    node_count           = 1
    vm_size              = "Standard_DS2_v2"
    vnet_subnet_id       = azurerm_subnet.aks_subnet.id
    zones                = ["1"]
    orchestrator_version = var.kubenetes_version
    os_disk_type         = "Managed"
    os_disk_size_gb      = 32
    type                 = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  ingress_application_gateway {
    gateway_id = azurerm_application_gateway.aks_application_gateway.id
  }

  role_based_access_control_enabled = true
}

resource "azurerm_user_assigned_identity" "aks_user_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name = "${azurerm_kubernetes_cluster.aks.name}-user-assigned-identity"
}

resource "azurerm_role_assignment" "aks_subnet" {
  scope                = azurerm_subnet.aks_subnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

resource "azurerm_role_assignment" "aks_acr" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "aks_managed_identity" {
  scope                = azurerm_user_assigned_identity.aks_user_identity.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

resource "azurerm_role_assignment" "aks_contributor" {
  scope                = azurerm_application_gateway.aks_application_gateway.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_user_identity.principal_id
}

resource "azurerm_role_assignment" "aks_resource_group_reader" {
  scope                = var.resource_group_id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.aks_user_identity.principal_id
}

resource "azurerm_role_assignment" "aks_agic_reader_resourcegroup" {
  scope                = var.resource_group_id
  role_definition_name = "Reader"
  principal_id         = azurerm_kubernetes_cluster.aks.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}
resource "azurerm_role_assignment" "aks_agic_contributor" {
  scope                = azurerm_application_gateway.aks_application_gateway.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}

resource "azurerm_role_assignment" "aks_agic_user_assigned_identity" {
  scope                = azurerm_user_assigned_identity.aks_application_gateway_user_identity.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_kubernetes_cluster.aks.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}
