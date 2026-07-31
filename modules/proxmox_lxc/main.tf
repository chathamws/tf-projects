terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.70.0"
    }
  }
}

# Dynamically request the next open ID directly from the Proxmox cluster api
data "proxmox_virtual_environment_cluster_next_vm_id" "next_id" {
  range_start = var.vm_id_range_start
  range_end   = var.vm_id_range_end
}

resource "proxmox_virtual_environment_container" "managed_lxc" {
  node_name    = var.node_name
  
  # Uses the discovered available ID from the cluster data source
  vm_id        = data.proxmox_virtual_environment_cluster_next_vm_id.next_id.id
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
  description = "The dynamically allocated VM/CT ID"
}

output "container_status" {
  value       = proxmox_virtual_environment_container.managed_lxc.started
  description = "The execution or runtime power state status tracking flag"
}
