terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.70.0"
    }
  }
}

resource "proxmox_virtual_environment_container" "managed_lxc" {
  node_name    = var.target_node
  unprivileged = true

  initialization {
    hostname = var.hostname
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
    template_file_id = var.template_file_id
    type             = var.os_type
  }

  disk {
    datastore_id = var.storage_pool
    size         = var.disk_size_gb
  }

  cpu {
    cores = var.cpu_cores
  }

  features {
    nesting = true
  }

  # 💎 ADD THIS LIFECYCLE GUARD TO STOP THE GHOST REBOOTS
  lifecycle {
    ignore_changes = [
      initialization[0].user_account,
      initialization[0].ip_config,
      initialization[0].dns
    ]
  }
}
