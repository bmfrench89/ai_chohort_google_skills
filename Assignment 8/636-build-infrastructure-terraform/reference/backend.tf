# Remote state in a Google Cloud Storage bucket.
#
# Terraform does NOT allow variables/interpolation in the backend block, so the bucket
# name must be a literal. Workflow the challenge lab uses:
#   1. Create the bucket first (via the google_storage_bucket resource in main.tf, or
#      `gsutil mb -l REGION gs://BUCKET`).
#   2. Uncomment the block below and set the real bucket name.
#   3. Run `terraform init` — Terraform detects the backend change and offers to migrate
#      your existing local state into the bucket. Answer "yes".
#
# terraform {
#   backend "gcs" {
#     bucket = "YOUR_PROJECT_ID-tf-state"
#     prefix = "terraform/state"
#   }
# }
