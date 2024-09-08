# Resource group details
rg_group_name = "test"
location      = "East US"

# vnet variables.
# azure.tfvars
prefix = "myapp"
resource_group_name = "myapp-rg"
address_space = ["10.0.0.0/16"]
address_prefixes = ["10.0.0.0/24"]
