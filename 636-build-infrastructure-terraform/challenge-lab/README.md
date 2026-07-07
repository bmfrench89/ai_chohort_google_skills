# Challenge Lab — GSP345 (working playbook)

*Build Infrastructure with Terraform on Google Cloud: Challenge Lab.* This file is a
placeholder playbook — **paste the full lab instructions when you launch it** and we'll fill
in the exact task-by-task steps and values, the same way we did for course 1's GSP330.

> [!NOTE]
> This is a Terraform challenge lab. Work happens in **Cloud Shell** (which has `terraform`,
> `gcloud`, and `gsutil` preinstalled and authenticated). Claude has no access to the lab —
> you run commands and paste back output.

## What to capture first (paste to me)

- `PROJECT_ID`
- Region / Zone
- The lab's assigned **bucket name**, **instance names**, **network/module names** (the
  auto-grader checks these exactly)

## Typical GSP345 task shape (confirm against the live lab)

- [ ] **Create the configuration** — `main.tf`, `variables.tf`, provider block; `terraform init`.
- [ ] **Import existing infrastructure** — `terraform import` two pre-created VMs into the config, then reconcile the config to match (`terraform plan` clean).
- [ ] **Configure remote state** — create a GCS bucket, add a `backend "gcs"` block, `terraform init` to migrate state.
- [ ] **Modify infrastructure** — change/add instances, `apply`.
- [ ] **Taint / replace** — force-recreate a resource (`terraform taint` or `-replace`), `apply`.
- [ ] **Add a module** — pull a module (e.g. `terraform-google-modules/network/google`) to create a VPC, `init` + `apply`.
- [ ] **Outputs / variables** — wire outputs and local/input variables as required.

## Reference templates

Correct `.tf` patterns to compare against live in [`../reference/`](../reference/) — provider
setup, a reusable instance module, remote GCS backend, variables, and outputs.

## Common grader gotchas

- Resource **names/labels must match exactly** what the lab specifies (instance names, bucket
  name, module name).
- After `import`, your `.tf` must describe the resource closely enough that `terraform plan`
  shows **no changes** (or only the intended ones).
- The backend block can't use variables — the bucket name is a literal; create the bucket
  before `terraform init`.
- Provider/module versions: pin what the lab asks, or let it default — mismatches cause plan errors.

## Final artifacts (commit here as we go)

<!-- drop the final main.tf, variables.tf, outputs.tf, modules/, backend config + a writeup -->
- Assigned PROJECT_ID / region / zone:
- Bucket / instance / module names:
- Badge URL:
