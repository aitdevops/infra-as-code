module "resource_group" {
  source              = "../../modules/resource_group"
  resource_group_name = var.rg_group_name
  location            = var.location
}
