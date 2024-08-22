variable "bucket_name" {
  description = "The name of the storage bucket."
  type        = string
}

variable "location" {
  description = "The location of the storage bucket (e.g., US, EU, ASIA)."
  type        = string
}

variable "force_destroy" {
  description = "Whether to allow Terraform to destroy the bucket if it contains objects."
  type        = bool
}

variable "uniform_bucket_level_access" {
  description = "Whether to enable uniform bucket-level access."
  type        = bool
}

variable "lifecycle_age" {
  description = "The age of objects before they are deleted by lifecycle management."
  type        = number
}

