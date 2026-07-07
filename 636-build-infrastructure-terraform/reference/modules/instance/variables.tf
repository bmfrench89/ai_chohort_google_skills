# Module inputs.

variable "instance_name" {
  description = "Name of the Compute Engine instance."
  type        = string
}

variable "machine_type" {
  description = "Machine type."
  type        = string
  default     = "e2-medium"
}

variable "zone" {
  description = "Zone to deploy the instance in."
  type        = string
}

variable "image" {
  description = "Boot disk image."
  type        = string
  default     = "debian-cloud/debian-12"
}
