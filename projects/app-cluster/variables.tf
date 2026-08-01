variable "container_root_password" {
  type      = string
  sensitive = true
}

variable "target_node" {
  type = string
}

variable "hostname" {
  type = string
}

variable "disk_size_gb" {
  type = number
}

variable "cpu_cores" {
  type = number
}
