variable "container_root_password" {
  type      = string
  sensitive = true
}

module "prod_lxc" {
  source = "../../../modules/proxmox_lxc"

  target_node             = "pve1"
  hostname                = "tf-prod-app" # Production naming convention
  container_root_password = var.container_root_password
  template_file_id        = "local:vztmpl/ubuntu-26.04-standard_26.04-1_amd64.tar.zst"
  os_type                 = "ubuntu"
  storage_pool            = "local-lvm"
  disk_size_gb            = 20            # Scaled up for production
  cpu_cores               = 2             # Scaled up for production
}
