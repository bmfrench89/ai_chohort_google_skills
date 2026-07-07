# Root configuration — provider setup, a module call, and a storage bucket.
# Reference template: swap project/region/zone and names for the lab's values.

terraform {
  required_version = ">= 1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Provision a Compute Engine VM via the local reusable module (see modules/instance).
module "web_instance" {
  source        = "./modules/instance"
  instance_name = "tf-web-instance"
  machine_type  = "e2-medium"
  zone          = var.zone
}

# A GCS bucket — also serves as the remote state backend target (see backend.tf).
resource "google_storage_bucket" "state_bucket" {
  name                        = "${var.project_id}-tf-state"
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true
}
