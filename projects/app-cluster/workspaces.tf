locals {
  # Each key in this map is a "workspace." To decommission a workspace,
  # delete its block and run `terraform apply` — Terraform will automatically
  # destroy the corresponding LXC container.
  workspaces = {
    dev = {
      target_node  = "pve1"
      hostname     = "tf-dev-app"
      disk_size_gb = 8
      cpu_cores    = 1
    }
    prod = {
      target_node  = "pve1"
      hostname     = "tf-prod-app"
      disk_size_gb = 20
      cpu_cores    = 1
    }
  }
}