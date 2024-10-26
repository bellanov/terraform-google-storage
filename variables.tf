# Variables
# 
# Input variables allow you to customize modules without altering their source code.
#================================================

variable "buckets" {
  description = "Cloud Storage Buckets."
  default     = {}
}

variable "artifact_registries" {
  description = "Artifact Registries."
  default     = {}
}

variable "location" {
  description = "Region in which to deploy infrastructure."
  type        = string
}

variable "project" {
  description = "Google Cloud Project that isolates this environment's infrastructure."
  type        = string
}
