# Terraform cheatsheet

Commands used across the Terraform labs. Cloud Shell has `terraform` preinstalled.

## Core workflow

```bash
terraform init                 # download providers/modules, configure backend
terraform fmt                  # rewrite files to canonical format
terraform validate             # validate syntax + internal consistency
terraform plan                 # preview changes (add -out=plan.tfplan to save)
terraform apply                # create/update (apply plan.tfplan, or -auto-approve)
terraform destroy              # tear everything down
terraform output               # show output values (terraform output -raw NAME for one)
```

## State management

```bash
terraform state list                       # list resources in state
terraform state show ADDRESS               # inspect one resource
terraform state rm ADDRESS                 # drop a resource from state (keeps real infra)
terraform state mv SRC DEST                # rename/move a resource in state
```

Remote backend (GCS): add a `backend "gcs"` block (literal bucket name), then
`terraform init` and answer **yes** to migrate local state to the bucket.

## Importing existing infrastructure

```bash
# 1. Write a matching resource/module block in your .tf first (can be minimal).
# 2. Import the real resource into that address:
terraform import google_compute_instance.NAME projects/PROJECT/zones/ZONE/instances/INSTANCE

# 3. terraform plan  -> reconcile .tf until it shows "No changes".
```

## Force-recreate a resource

```bash
# Preferred (Terraform 0.15.2+):
terraform apply -replace="google_compute_instance.NAME"

# Older syntax:
terraform taint google_compute_instance.NAME
terraform apply
```

## Modules

```bash
# Registry module example (in .tf):
#   module "network" {
#     source  = "terraform-google-modules/network/google"
#     version = "~> 9.0"
#     ...
#   }
terraform init      # required after adding/changing a module source
terraform get       # download/update modules only
```

## Handy

```bash
terraform version
terraform providers
terraform show                 # human-readable current state
terraform plan -destroy        # preview a destroy
gcloud config get-value project   # confirm the active project the provider will use
```
