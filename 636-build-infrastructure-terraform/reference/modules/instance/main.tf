# A minimal, reusable Compute Engine instance module.
# Demonstrates the module pattern the badge tests: inputs (variables) → resource → outputs.

resource "google_compute_instance" "vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"
    access_config {} # ephemeral external IP
  }
}
