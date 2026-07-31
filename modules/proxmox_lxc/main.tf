terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.70.0"
    }
  }
}

resource "proxmox_virtual_environment_container" "managed_lxc" {
  node_name    = var.node_name
  vm_id        = var.vm_id
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

output "container_id" {
  value       = proxmox_virtual_environment_container.managed_lxc.vm_id
  description = "The allocated VM/CT ID"
}
