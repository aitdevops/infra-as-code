# Step 1: VPC
module "vpc" {
  source     = "../../modules/vpc"
  project_id = var.project_id
  vpc_name   = var.vpc_name
  region     = var.region
}

# Step 2: Subnet
module "subnet" {
  source     = "../../modules/subnet"
  project_id = var.project_id
  vpc_name   = module.vpc.vpc_name
  region     = var.region
}

# Step 3: Artifact Repository
module "artifact-repository" {
  source     = "../../modules/artifact-repository"
  project_id = var.project_id
  region     = var.region
  zone       = var.zone
}

# Step 4: GKE Cluster
module "gke" {
  source                    = "../../modules/gke"
  project_id                = var.project_id
  cluster_name              = var.cluster_name
  vpc_name                  = module.vpc.vpc_name
  subnet_name               = module.subnet.private_subnet_name
  node_pools                = var.node_pools
  namespaces                = var.namespaces
  region                    = var.region
  zone                      = var.zone
  gke_service_account_email = var.gke_service_account_email
  gke_service_account_name  = var.gke_service_account_name
}


# Step 5: Cloud DNS
module "cloud-dns" {
  source           = "../../modules/cloud-dns"
  project_id       = var.project_id
  domain_name      = var.domain_name
  dns_managed_zone = var.dns_managed_zone
  a_record_ip      = var.a_record_ip
  db_ip            = var.db_ip
  redis_ip         = var.redis_ip
  name             = var.name
  argo_service     = var.argo_service
  auth_service     = var.auth_service
  user_service     = var.user_service
  approval_service = var.approval_service
  database_service = var.database_service
  redis_service    = var.redis_service
}

# Step 6: PostgreSQL
module "gcp-postgresql" {
  source          = "../../modules/gcp-postgresql"
  instance_name   = var.postgres_instance_name
  region          = var.region
  instance_tier   = var.postgres_instance_tier
  private_network = module.vpc.vpc_name
  project_id      = var.project_id
  database_name   = var.database_name
}

# # Step 7: Cloud Function (Optional)
# module "cloud_function" {
#   source      = "../../modules/cloud-function"
#   project_id  = var.project_id
#   region      = var.region
#   zip_file    = var.zip_file
#   service_account_email = var.service_account_email
# }
