locals {
  # Each key in this map is a "workspace." To decommission a workspace,
  # delete its block and run `terraform apply` — Terraform will automatically
  # destroy the corresponding LXC container.
  workspaces = {
    dev = {
      target_node  = "pve1"
      hostname     = "test2-dev"
      disk_size_gb = 8
      cpu_cores    = 1
    }
    prod = {
      target_node  = "pve1"
      hostname     = "test2-prod"
      disk_size_gb = 8
      cpu_cores    = 1
    }
    stg = {
      target_node  = "pve1"
      hostname     = "test2-stg"
      disk_size_gb = 8
      cpu_cores    = 1
    }
  }
}