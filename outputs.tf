# Outputs
# 
# Output values make information about your infrastructure available on the command line, 
# and can expose information for other Terraform configurations to use.
#================================================

output "buckets" {
  description = "Cloud Storage Buckets."
  value       = { for bucket in google_storage_bucket.bucket : bucket.name => tomap({ "name" = bucket.name, "url" = bucket.url }) }
}

output "artifact_registries" {
  description = "Artifact Registries."
  value       = { for registry in google_artifact_registry_repository.registry : registry.name => tomap({ "name" = registry.name, "url" = registry.id }) }
}