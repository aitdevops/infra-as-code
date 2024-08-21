provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file_path)
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}


module "vpc" {
  source      = "../../modules/vpc"
  project_id  = var.project_id
  vpc_name    = var.vpc_name
  region      = var.region
}

module "subnet" {
  source      = "../../modules/subnet"
  project_id  = var.project_id
  vpc_name    = module.vpc.vpc_name
  region      = var.region
}

module "gke" {
  source               = "../../modules/gke"
  project_id           = var.project_id
  cluster_name         = var.cluster_name
  vpc_name             = module.vpc.vpc_name
  subnet_name          = module.subnet.private_subnet_name
  node_pools           = var.node_pools
  region               = var.region
  zone                 = var.zone
}

module "postgresql" {
  source            = "../../modules/gcp-postgresql"
  instance_name     = var.postgres_instance_name
  region            = var.region
  instance_tier     = var.postgres_instance_tier
  private_network   = module.vpc.vpc_name
  project_id        = var.project_id
  database_name     = var.database_name
}

module "service_account" {
  source      = "../../modules/service-account"
  project_id  = var.project_id
  region      = var.region
  zone        = var.zone
}

module "artifact-repository" {
  source      = "../../modules/artifact-repository"
  project_id  = var.project_id
  region      = var.region
  zone        = var.zone
}

module "helm" {
  source            = "../../modules/helm"
}