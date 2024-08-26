provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file_path)
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

module "service_account" {
  source      = "../../modules/service-account"
  project_id  = var.project_id
  region      = var.region
  zone        = var.zone
}

module "gke" {
  source               = "../../modules/gke"
  project_id           = var.project_id
  cluster_name         = var.cluster_name
  vpc_name             = module.vpc.vpc_name
  subnet_name          = module.subnet.private_subnet_name
  node_pools           = var.node_pools
  namespaces           = var.namespaces
  region               = var.region
  zone                 = var.zone
  gke_service_account_email = module.service_account.gke_service_account_email  # Pass the service account email
  gke_service_account_name  = module.service_account.gke_service_account_name   # Pass the service account name
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


module "artifact-repository" {
  source      = "../../modules/artifact-repository"
  project_id  = var.project_id
  region      = var.region
  zone        = var.zone
}

module "cloud-dns" {
  source                = "../../modules/cloud-dns"
  project_id            = var.project_id
  credentials_file_path = var.credentials_file_path
  domain_name           = var.domain_name
  dns_managed_zone      = var.dns_managed_zone
  a_record_ip            = var.a_record_ip
  name                  = var.name
  argo_service          = var.argo_service
  auth_service          = var.auth_service
  user_service          = var.user_service
  approval_service      = var.approval_service
}

module "cloud_storage" {
  source                      = "../../modules/cloud-storage"
  bucket_name                 = var.bucket_name
  location                    = var.location
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access
  lifecycle_age               = var.lifecycle_age
}
