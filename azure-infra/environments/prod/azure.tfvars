# Resource group details
rg_group_name = "test"
location      = "East US"

# vnet variables.
vnet_name = "aitdevops-vnet"
resource_group_name = "aitdevops"
private_subnet_name = "aitdevops-private-subnet"
nat_gateway_name    = "aitdevops-nat-gateway"
private_subnet_address_prefixes = ["10.0.1.0/24"]
address_space             = ["10.0.0.0/16"]