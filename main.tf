terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.70.0" 
    }
  }
}

# These variables will be filled by GitHub environment variables automatically
variable "pm_api_url" { type = string }
variable "pm_api_token_id" { type = string }
variable "pm_api_token_secret" { type = string }

provider "proxmox" {
  endpoint = var.pm_api_url
  api_token = "${var.pm_api_token_id}=${var.pm_api_token_secret}"
  insecure  = true # Set to false if you have a valid SSL certificate on Proxmox
}

# Example description of a target LXC you want to manage
resource "proxmox_virtual_environment_container" "managed_lxc" {
  node_name    = "pve1" # Change to your exact Proxmox node name
  vm_id        = 200   # Change to an unused VM/LXC ID
  unprivileged = true

  initialization {
    hostname = "tf-managed-app"
    
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  template {
    # Path to an existing container template on your Proxmox storage
    file_id = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst" 
  }
}
