terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.70.0"
    }
  }
}

provider "proxmox" {
  # Endpoints and tokens are completely empty here.
  # They will be read natively from PROXMOX_VE_* environment variables.
  insecure = true 
}
