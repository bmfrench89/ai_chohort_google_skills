# Module outputs — consumed by the root config (see ../../outputs.tf).

output "instance_name" {
  description = "Name of the created instance."
  value       = google_compute_instance.vm.name
}

output "instance_ip" {
  description = "Internal IP of the created instance."
  value       = google_compute_instance.vm.network_interface[0].network_ip
}
