terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.70.0"
    }
  }
}

# The data source has been removed. By omitting the 'vm_id' attribute below,
# the bpg/proxmox provider will natively find and auto-allocate an available ID.
resource "proxmox_virtual_environment_container" "managed_lxc" {
  node_name    = var.node_name
  unprivileged = true

  initialization {
    hostname = var.hostname
    user_account {
      password = var.container_root_password
    }
    ip_config {
      ipv4 {
        address = var.ip_address
      }
    }
  }

  operating_system {
    template_file_id = "local:vztmpl/ubuntu-26.04-standard_26.04-1_amd64.tar.zst"
    type             = "ubuntu"
  }

  disk {
    datastore_id = "local-lvm"
    size         = var.disk_size
  }

  cpu {
    cores = var.cores
  }

  features {
    nesting = true
  }
}

# Output the assigned ID and container running status back to the parent project
output "container_id" {
  value       = proxmox_virtual_environment_container.managed_lxc.vm_id
  description = "The natively allocated VM/CT ID"
}

output "container_status" {
  value       = proxmox_virtual_environment_container.managed_lxc.started
  description = "The execution runtime power status"
}
