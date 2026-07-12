# Outputs surfaced after `terraform apply` (and queryable via `terraform output`).

output "instance_name" {
  description = "Name of the provisioned VM."
  value       = module.web_instance.instance_name
}

output "instance_ip" {
  description = "Internal IP of the provisioned VM."
  value       = module.web_instance.instance_ip
}

output "state_bucket" {
  description = "GCS bucket available for remote state."
  value       = google_storage_bucket.state_bucket.name
}
