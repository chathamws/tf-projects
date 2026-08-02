# projects/app-cluster/main.tf

module "app_lxc" {
  # Fixes the path traversal bug by using the absolute root path token
  source = "${path.root}/../../modules/proxmox_lxc"

  for_each = local.workspaces

  target_node             = each.value.target_node
  hostname                = each.value.hostname
  container_root_password = var.container_root_password
  disk_size_gb            = each.value.disk_size_gb
  cpu_cores               = each.value.cpu_cores

  # Static shared settings across environments
  template_file_id = "local:vztmpl/ubuntu-26.04-standard_26.04-1_amd64.tar.zst"
  os_type          = "ubuntu"
  storage_pool     = "local-lvm"
}