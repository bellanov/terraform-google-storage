# Module Definition
# 
# Contains the main set of configuration for the module.
#================================================

# Random string used to uniquely identify infrastructure, enabling the reusability of names.
resource "random_string" "code" {
  length  = 8
  upper   = false
  special = false
}

# Iterate over list of buckets and procure the resources.
resource "google_storage_bucket" "bucket" {
  for_each      = var.buckets
  name          = "${each.key}-${random_string.code.result}"
  project       = var.project
  location      = var.location
  force_destroy = true

  # Disable public access to the bucket.
  public_access_prevention = each.value.public_access_prevention

  # Delete objects after 30 days
  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }

  # Abort incomplete multipart uploads after 1 day
  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

# Iterate over list of artifact registries and procure the resources.
resource "google_artifact_registry_repository" "registry" {
  for_each      = var.artifact_registries
  location      = each.value.location
  repository_id = each.key
  description   = each.value.description
  format        = each.value.format
}
