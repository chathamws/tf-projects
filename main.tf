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
variable "pm_api_token_secret" { type = string }

provider "proxmox" {
  endpoint  = var.pm_api_url
  api_token = "${var.pm_api_token_id}=${var.pm_api_token_secret}"
  insecure  = true 
}

resource "proxmox_virtual_environment_container" "managed_lxc" {
  node_name    = "pve1" # Change to your exact Proxmox node name
  vm_id        = 200   # Change to an unused VM/LXC ID
  unprivileged = true

  initialization {
    hostname = "tf-managed-app"

    # FIX: Move the password inside a dedicated user_account configuration block
    user_account {
      password = var.container_root_password
    }
    
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  # FIX: Replaced the old template block with the correct bpg structure
  operating_system {
    template_file_id = "local:vztmpl/ubuntu-26.04-standard_26.04-1_amd64.tar.zst" 
    type             = "ubuntu" # Optional, help provider identify OS type
  }

 # FIX: Tell Proxmox where to deploy the target container's system drive
  disk {
    datastore_id = "local-lvm" # <-- Change to your node's storage (e.g. local-lvm, local-zfs)
    size         = 8           # Allocation size in GB
  }

  # FIX: Suppresses the Systemd warning by preemptively enabling nesting
  features {
    nesting = true
  }


}

