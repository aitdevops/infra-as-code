# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Reference existing VNet and Subnet
data "azurerm_virtual_network" "vnet" {
  name                = "aitdevops-vnet"
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_subnet" "subnet" {
  name                 = "aitdevops-subnet"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-aks"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size

    vnet_subnet_id = data.azurerm_subnet.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "production"
  }
}

# Output the AKS cluster kubeconfig
output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].raw_kube_config
}

