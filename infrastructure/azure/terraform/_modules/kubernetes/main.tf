resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  kubernetes_version  = "1.21.2"
  location            = var.rg_loc
  resource_group_name = var.rg_name
  node_resource_group = var.nrg_name
  dns_prefix          = var.dns_name

  network_profile {
    network_plugin = "kubenet"
    network_policy = "calico"
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      managed = true
      admin_group_object_ids = [
        var.admin_group_object_id
      ]
    }
  }

  default_node_pool {
    name                  = var.nd_pool
    node_count            = 1
    vm_size               = "Standard_D2s_v3"
        # "Standard_D2s_v3" - Intel(R) Xeon(R) Platinum 8171M CPU @ 2.60GHz
    enable_auto_scaling   = true
    min_count             = "1"
    max_count             = "5"
    enable_node_public_ip = false
    type                  = "VirtualMachineScaleSets"

    tags = {
        department = "DAC"
    }

  }

  auto_scaler_profile {
    balance_similar_node_groups      = false
    expander                         = "least-waste"
    max_graceful_termination_sec     = "600"
    scale_down_delay_after_add       = "5m"
    scan_interval                    = "10s"
    scale_down_unneeded              = "5m"
    scale_down_utilization_threshold = "0.5"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
      Department = "DAC"
  }
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

locals {
  resource_id = azurerm_kubernetes_cluster.aks.id
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "aks_oid" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  sensitive = true
}

output "aks_pid" {
  value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  sensitive = true
}