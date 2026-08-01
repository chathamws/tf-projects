# Fetch sensitive password via standard TF_VAR variable
variable "container_root_password" {
  type      = string
  sensitive = true
}

module "dev_lxc" {
  source = "../../../modules/proxmox_lxc"

  target_node             = "pve1"
  hostname                = "tf-dev-app"
  container_root_password = var.container_root_password
  template_file_id        = "local:vztmpl/ubuntu-26.04-standard_26.04-1_amd64.tar.zst"
  os_type                 = "ubuntu"
  storage_pool            = "local-lvm"
  disk_size_gb            = 8
  cpu_cores               = 1
}
