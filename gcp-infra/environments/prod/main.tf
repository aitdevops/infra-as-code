# Step 1: Service Account
module "service_account" {
  source      = "../../modules/service-account"
  project_id  = var.project_id
  region      = var.region
  zone        = var.zone
}

# Step 2: Cloud Storage (for Terraform state)
module "cloud_storage" {
  source                      = "../../modules/cloud-storage"
  bucket_name                 = var.bucket_name
  location                    = var.location
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access
  lifecycle_age               = var.lifecycle_age

  depends_on = [module.service_account]  # Ensures this runs after service account creation
}

# Step 3: VPC
module "vpc" {
  source      = "../../modules/vpc"
  project_id  = var.project_id
  vpc_name    = var.vpc_name
  region      = var.region

  depends_on = [module.cloud_storage]  # Ensures this runs after cloud storage
}

# Step 4: Subnet
module "subnet" {
  source      = "../../modules/subnet"
  project_id  = var.project_id
  vpc_name    = module.vpc.vpc_name
  region      = var.region

  depends_on = [module.vpc]  # Ensures this runs after VPC
}

# Step 5: Artifact Repository
module "artifact-repository" {
  source      = "../../modules/artifact-repository"
  project_id  = var.project_id
  region      = var.region
  zone        = var.zone

  depends_on = [module.vpc]  # Ensures this runs after VPC (or Subnet if necessary)
}

# Step 6: GKE Cluster
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
  gke_service_account_email = module.service_account.gke_service_account_email
  gke_service_account_name  = module.service_account.gke_service_account_name

  depends_on = [module.artifact-repository, module.subnet]  # Ensures this runs after subnet and artifact repository
}

# Step 7: Cloud DNS
module "cloud_dns" {
  source                = "../../modules/cloud-dns"
  project_id            = var.project_id
  credentials_file_path = var.credentials_file_path
  domain_name           = var.domain_name
  dns_managed_zone      = var.dns_managed_zone
  a_record_ip           = var.a_record_ip
  db_ip                 = var.db_ip
  redis_ip              = var.redis_ip
  name                  = var.name
  argo_service          = var.argo_service
  auth_service          = var.auth_service
  user_service          = var.user_service
  approval_service      = var.approval_service
  database_service      = var.database_service
  redis_service         = var.redis_service

  depends_on = [module.gke]  # Ensures this runs after GKE cluster is up
}

# Step 8: PostgreSQL
module "postgresql" {
  source            = "../../modules/gcp-postgresql"
  instance_name     = var.postgres_instance_name
  region            = var.region
  instance_tier     = var.postgres_instance_tier
  private_network   = module.vpc.vpc_name
  project_id        = var.project_id
  database_name     = var.database_name

  depends_on = [module.subnet]  # Ensures this runs after subnet creation
}

# # Step 9: Cloud Function (Optional)
# module "cloud_function" {
#   source      = "../../modules/cloud-function"
#   project_id  = var.project_id
#   region      = var.region
#   zip_file    = var.zip_file
#   service_account_email = var.service_account_email

#   depends_on = [module.gke, module.postgresql]  # Ensures this runs after GKE and PostgreSQL are ready
# }
