variable "pm_api_url" { type = string }
variable "pm_api_token_id" { type = string }
variable "pm_api_token_secret" { type = string }

variable "container_root_password" {
  type      = string
  sensitive = true
}

variable "hostname" { type = string }

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

variable "vm_id" { type = number }
