variable "node_name" {
  type    = string
  default = "pve1"
}

variable "vm_id" {
  type = number
}

variable "hostname" {
  type = string
}

variable "container_root_password" {
  type      = string
  sensitive = true
}

variable "ip_address" {
  type    = string
  default = "dhcp"
}

variable "cores" {
  type    = number
  default = 1
}

variable "disk_size" {
  type    = number
  default = 8
}
