terraform {
  backend "gcs" {
    bucket  = "terraform-aitdevops"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("/Users/rajeev/Desktop/repos/service-account.json")
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

module "postgresql" {
  source            = "../../modules/gcp-postgresql"
  instance_name     = "prod-postgres"
  region            = var.region
  instance_tier     = "db-f1-micro"
  private_network   = module.vpc.vpc_name  # Pass only the VPC name
  project_id        = var.project_id       # Pass the project ID
  database_name     = "mydatabase"
  database_user     = "myuser"
  database_password = "mypassword"
}

