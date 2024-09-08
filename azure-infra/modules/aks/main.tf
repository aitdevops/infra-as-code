# Reference existing VNet
data "azurerm_virtual_network" "vnet" {
  name                = "aitdevops-vnet"
  resource_group_name = "aitdevops-rg" # Adjust if necessary
}

# Reference existing Subnet
data "azurerm_subnet" "subnet" {
  name                 = "aitdevops-subnet"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = "aitdevops-rg" # Adjust if necessary
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = "aitdevops-rg" # Use existing resource group
  dns_prefix          = "${var.prefix}-aks"

  network_profile {
    network_plugin     = "azure"        # or "kubenet" depending on your needs
    service_cidr       = "10.1.0.0/16"  # Ensure this does not overlap with existing subnets
    dns_service_ip     = "10.1.0.10"    # Must be within the service CIDR
    load_balancer_sku  = "standard"
    outbound_type      = "loadBalancer"
  }

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
