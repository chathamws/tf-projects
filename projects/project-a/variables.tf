variable "pm_api_url" { type = string }
variable "pm_api_token_id" { type = string }
variable "pm_api_token_secret" { type = string }
variable "container_root_password" {
  type      = string
  sensitive = true
}
variable "ip_address" {
  type    = string
  default = "dhcp"
}
variable "disk_size" { type = number; default = 8 }

# Ranges map configurations instead of hardcoded singular points
variable "vm_id_range_start" { type = number }
variable "vm_id_range_end" { type = number }
