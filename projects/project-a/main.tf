terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.70.0"
    }
  }
  backend "local" {}
}

provider "proxmox" {
  endpoint  = var.pm_api_url
  api_token = "${var.pm_api_token_id}=${var.pm_api_token_secret}"
  insecure  = true
}

module "lxc_environment" {
  source = "../../modules/proxmox_lxc"

  hostname                = var.hostname
  ip_address              = var.ip_address
  container_root_password = var.container_root_password
  cores                   = var.cores
  disk_size               = var.disk_size
}

output "allocated_id" {
  value = module.lxc_environment.container_id
}

output "execution_status" {
  value = module.lxc_environment.container_status
}
