terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.70.0" 
    }
  }
}

variable "pm_api_url" { type = string }
variable "pm_api_token_id" { type = string }
variable "pm_api_token_secret" { type = string }

variable "container_root_password" {
  type      = string
  sensitive = true
}

provider "proxmox" {
  endpoint  = var.pm_api_url
  api_token = "${var.pm_api_token_id}=${var.pm_api_token_secret}"
  insecure  = true 
  # FIX: Removed the unsupported ignore_subsequent_warnings argument
}

resource "proxmox_virtual_environment_container" "managed_lxc" {
  node_name    = "pve1" 
  vm_id        = 200   
  unprivileged = true

  initialization {
    hostname = "tf-managed-app"
    
    user_account {
      password = var.container_root_password
    }

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  operating_system {
    template_file_id = "local:vztmpl/ubuntu-26.04-standard_26.04-1_amd64.tar.zst" 
    type             = "ubuntu" 
  }

  disk {
    datastore_id = "local-lvm" 
    size         = 8           
  }

  # Enforced nesting will cleanly suppress the task warnings natively
  features {
    nesting = true
  }
}
