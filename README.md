# tf-projects

Terraform-managed Proxmox LXC containers, organized as reusable modules + per-project configurations.

## Structure

```
modules/proxmox_lxc/     # Reusable LXC container module
projects/app-cluster/    # App-cluster project (dev + prod)
projects/test-app/       # Test-app project (dev + prod)
```

## How Workspaces Work

Each project defines its environments (workspaces) as a `locals` map in `workspaces.tf`:

```hcl
locals {
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
```

The `main.tf` uses `for_each` to create one LXC container per workspace key:

```hcl
module "app_lxc" {
  source = "${path.root}/../../modules/proxmox_lxc"

  for_each = local.workspaces

  target_node             = each.value.target_node
  hostname                = each.value.hostname
  container_root_password = var.container_root_password
  disk_size_gb            = each.value.disk_size_gb
  cpu_cores               = each.value.cpu_cores
  # ...
}
```

### Adding a workspace

Add a new key to the `workspaces` map in `workspaces.tf`, then run:

```bash
cd projects/app-cluster
terraform init
terraform apply -var="container_root_password=..."
```

### Decommissioning a workspace (auto-terminate)

**Delete the workspace's block** from the `workspaces` map in `workspaces.tf`, then run:

```bash
terraform apply -var="container_root_password=..."
```

Terraform will detect that the resource instance is no longer declared and **automatically destroy** the corresponding LXC container. No manual `terraform destroy` needed.

### Applying changes to all workspaces

A single `terraform apply` creates/updates/destroys all workspace instances in one run — no need to switch between Terraform workspaces or pass separate `.tfvars` files.