# Input variables for the root configuration.

variable "project_id" {
  description = "The Google Cloud project ID."
  type        = string
}

variable "region" {
  description = "Region for regional resources (e.g. the state bucket)."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zone for zonal resources (e.g. Compute instances)."
  type        = string
  default     = "us-central1-a"
}
