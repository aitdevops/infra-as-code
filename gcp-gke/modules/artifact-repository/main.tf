resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "aitdevops-gke"
  description   = "place to store images"
  format        = "docker"

  cleanup_policy_dry_run = true

  cleanup_policies {
    id     = "delete-old-artifacts"
    action = "DELETE"
    condition {
      tag_state  = "ANY"
      older_than = "432000s"  # 5 days in seconds
    }
  }

  cleanup_policies {
    id     = "keep-recent-versions"
    action = "KEEP"
    most_recent_versions {
      keep_count = 10
    }
  }
}
