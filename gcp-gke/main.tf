provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file("/Users/rajeev/Desktop/gcp-infra/credentials/aitdevops8-serviceaccount.json")
}

module "vpc" {
  source = "../modules/vpc"
  project_id = var.project_id
  vpc_name   = var.vpc_name
}

module "subnet" {
  source    = "../modules/subnet"
  project_id = var.project_id
  vpc_name   = module.vpc.vpc_name
}

module "gke" {
  source       = "../modules/gke"
  project_id   = var.project_id
  cluster_name = var.cluster_name
  vpc_name     = module.vpc.vpc_name
  subnet_name  = module.subnet.private_subnet_name
}
