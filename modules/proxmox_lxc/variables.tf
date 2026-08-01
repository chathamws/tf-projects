variable "target_node" {
  type        = string
  description = "The Proxmox node to deploy the LXC on"
}

variable "hostname" {
  type        = string
  description = "The hostname for the container"
}

variable "container_root_password" {
  type        = string
  sensitive   = true
  description = "Root password for the LXC container"
}

variable "template_file_id" {
  type        = string
  description = "The volume and path to the OS template"
}

variable "os_type" {
  type        = string
  default     = "ubuntu"
  description = "The operating system type"
}

variable "storage_pool" {
  type        = string
  description = "The Proxmox storage pool for the disk"
}

variable "disk_size_gb" {
  type        = number
  description = "Disk size allocation in GB"
}

variable "cpu_cores" {
  type        = number
  description = "Number of CPU cores allocated"
}
