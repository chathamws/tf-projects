terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.70.0"
    }
  }

  # This empty block enables dynamic state path overrides
  backend "local" {}
}

provider "proxmox" {
  endpoint  = var.pm_api_url
  api_token = "${var.pm_api_token_id}=${var.pm_api_token_secret}"
  insecure  = true
}

module "lxc_environment" {
  source = "../../modules/proxmox_lxc"

  vm_id                   = var.vm_id
  hostname                = var.hostname
  ip_address              = var.ip_address
  container_root_password = var.container_root_password
  cores                   = var.cores
  disk_size               = var.disk_size
}
