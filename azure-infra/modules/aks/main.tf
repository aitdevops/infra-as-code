# Resource Group

# Reference existing VNet and Subnet
data "azurerm_virtual_network" "vnet" {
  name                = "aitdevops-vnet"
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = "aitdevops-subnet"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name = var.resource_group_name
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
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

