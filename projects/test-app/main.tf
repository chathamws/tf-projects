# projects/app-cluster/main.tf

module "app_lxc" {
  # Fixes the path traversal bug by using the absolute root path token
  source = "${path.root}/../../modules/proxmox_lxc"

  target_node             = var.target_node
  hostname                = var.hostname
  container_root_password = var.container_root_password
  disk_size_gb            = var.disk_size_gb
  cpu_cores               = var.cpu_cores

  # Static shared settings across environments
  template_file_id        = "local:vztmpl/ubuntu-26.04-standard_26.04-1_amd64.tar.zst"
  os_type                 = "ubuntu"
  storage_pool            = "local-lvm"
}
