# GSP345 — Completion Record

**Badge:** Build Infrastructure with Terraform on Google Cloud
**Completed:** 2026-07-06 · **Result:** ✅ 100/100 — all 7 tasks passed → skill badge earned
**Badge URL:** _(add when available)_

Final config in [`solution/`](solution/).

## Environment (temporary lab — no longer live)

| Item | Value |
|------|-------|
| Project ID | `qwiklabs-gcp-04-588607d7d653` |
| Region / Zone | `europe-west1` / `europe-west1-d` |
| Pre-created instances | `tf-instance-1`, `tf-instance-2` (imported; `e2-micro`, `debian-11`) |
| Third instance | `tf-instance-641560` (added in Task 4, destroyed in Task 5) |
| State bucket | `tf-bucket-493120` (GCS backend, prefix `terraform/state`) |
| VPC | `tf-vpc-537674` (global routing) |
| Subnets | `subnet-01` (10.10.10.0/24), `subnet-02` (10.10.20.0/24) |
| Firewall | `tf-firewall` — ingress TCP:80 from 0.0.0.0/0 |
| Terraform / providers | terraform v1.x · **google v6.x** (network module forced `< 7`) |

## Tasks

1. **Config files** — root + module `variables.tf` (region/zone/project_id), `main.tf` with terraform block + provider (incl. zone), modules dir structure, `terraform init`.
2. **Import** — wrote minimal `tf-instance-1`/`-2` resources (machine_type, boot_disk, network_interface, metadata_startup_script, allow_stopping_for_update) and `terraform import`ed them into `module.instances`; apply updated in-place.
3. **Remote backend** — storage module bucket, then `backend "gcs"` with `prefix = "terraform/state"`, `init` migrated state.
4. **Modify** — all instances → `e2-standard-2`, added 3rd instance.
5. **Destroy** — removed the 3rd instance.
6. **Registry module** — `terraform-google-modules/network/google` **v10.0.0**, VPC + 2 subnets, then wired instances onto the subnets.
7. **Firewall** — `tf-firewall` allowing TCP:80 ingress from 0.0.0.0/0 on the VPC.

## Gotchas hit (worth remembering for future Terraform labs)

- **Provider version trap:** network module **v10.0.0 requires google `< 7.0.0`**, but the
  earlier steps had locked **google v7.39.0** → `terraform init` failed with a version
  conflict. Fix: **`terraform init -upgrade`** to re-resolve down to google **6.x**.
- **`-target` for ordering:** instances referenced the subnets by *string name* (no implicit
  dependency), so a plain apply raced ahead and 404'd on `subnet-01`. Fix: create the network
  first with **`terraform apply -target=module.vpc`**, then a normal apply for the instances.
- **State stamped by newer provider:** after downgrading to google 6.x, the bucket state
  (written by 7.x, with a `deletion_policy` attribute) failed to decode →
  *"managed by a newer provider version."* Fix: **`terraform state rm` + `terraform import`**
  the bucket to rewrite its state entry under 6.x. (The bucket itself was untouched.)
- The `enable_flow_logs` **deprecation warnings** from the network module are harmless.
- Grader-checked exact names: `tf-vpc-537674`, `subnet-01/-02`, `tf-bucket-493120`,
  `tf-firewall`, `tf-instance-641560`, backend prefix `terraform/state`.
