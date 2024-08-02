provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file("/Users/rajeev/Desktop/repos/gcp-infra/credentials/aitdevops8-serviceaccount.json")
}

module "vpc" {
  source      = "../../modules/vpc"
  project_id  = var.project_id
  vpc_name    = var.vpc_name
}

module "subnet" {
  source      = "../../modules/subnet"
  project_id  = var.project_id
  vpc_name    = module.vpc.vpc_name
}

module "gke" {
  source       = "../../modules/gke"
  project_id   = var.project_id
  cluster_name = var.cluster_name
  vpc_name     = module.vpc.vpc_name
  subnet_name  = module.subnet.private_subnet_name
  node_count   = var.node_count
  node_machine_type = var.node_machine_type
  min_node_count = var.min_node_count
  max_node_count = var.max_node_count
  region       = var.region
  zone         = var.zone
}