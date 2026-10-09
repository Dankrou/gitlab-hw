variable "zone" {
  description = "Availability zone shared by both VMs and their subnet."
  type        = string
  default     = "ru-central1-a"
}

variable "ssh_public_key_file" {
  description = "Path to your public SSH key (.pub), on the Terraform machine."
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "admin_cidr" {
  description = "Your public IPv4 address with /32, allowed to connect over SSH."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_cidr))
    error_message = "Specify an IPv4 CIDR, for example 203.0.113.10/32."
  }
}

variable "preemptible" {
  description = "Use interruptible VMs for the homework; false uses regular VMs."
  type        = bool
  default     = true
}
