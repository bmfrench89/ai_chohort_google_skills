# Challenge Lab — GSP345 (working playbook)

Full instructions: [`GSP345-full-instructions.md`](GSP345-full-instructions.md). This is our
working playbook — values to capture, task order, key HCL, and gotchas.

> [!WARNING]
> **Only 30 minutes**, and Terraform **isn't pre-installed**. Install it first (below), and
> `terraform plan && terraform apply` after **every** task so the grader can verify.

## How we work it

Run everything in **Cloud Shell**; paste me the assigned values + any errors, and I'll hand
you exact file contents and commands. Claude has no access to the lab.

## Step 0 — install Terraform (do immediately)

```bash
cat <<'EOF' > ~/.customize_environment
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install -y terraform
EOF
bash ~/.customize_environment
terraform --version
```

## Values to capture (paste to me) — grader checks these exactly

| Value | Used in |
|-------|---------|
| `region` / `zone` (assigned) | all resources / provider |
| `project_id` | provider, firewall network path |
| **Bucket Name** | Task 3 storage bucket + backend |
| **Instance Name** (3rd instance) | Task 4 / removed in Task 5 |
| **VPC Name** | Task 6 network module + Task 7 firewall |
| `tf-instance-1` / `-2` **machine_type + boot disk image** | Task 2 import (read from console) |

## Task checklist

- [ ] **1 — Config files**: create `main.tf`, `variables.tf`, and `modules/instances/{instances,outputs,variables}.tf` + `modules/storage/{storage,outputs,variables}.tf`. Root + module `variables.tf` each get `region`, `zone`, `project_id`. `main.tf` = terraform block + google provider (with **zone**). `terraform init`.
- [ ] **2 — Import** `tf-instance-1` & `tf-instance-2` into the instances module. Minimal args only: `machine_type`, `boot_disk`, `network_interface`, `metadata_startup_script`, `allow_stopping_for_update`. `terraform import module.instances.google_compute_instance.NAME PROJECT/ZONE/NAME` → apply.
- [ ] **3 — Remote backend**: storage module bucket (**Bucket Name**, `location=US`, `force_destroy=true`, `uniform_bucket_level_access=true`) → apply → add `backend "gcs"` with **`prefix = "terraform/state"`** → `init` → **yes** to migrate.
- [ ] **4 — Modify**: all three instances → **`e2-standard-2`**; add 3rd instance **Instance Name**. init + apply.
- [ ] **5 — Destroy**: remove **Instance Name** from config. init + apply.
- [ ] **6 — Registry module**: network module **version `10.0.0`**, VPC **VPC Name**, global routing, subnets `subnet-01` (`10.10.10.0/24`) + `subnet-02` (`10.10.20.0/24`) in region. apply. Then wire `tf-instance-1`→`subnet-01`, `tf-instance-2`→`subnet-02` (`network` = VPC Name + `subnetwork`).
- [ ] **7 — Firewall**: `google_compute_firewall` **`tf-firewall`** on **VPC Name**, ingress `tcp:80`, `source_ranges=["0.0.0.0/0"]`. init + apply.

## Gotchas

- **Import addresses** are module-scoped: `module.instances.google_compute_instance.tf-instance-1`.
- The `metadata_startup_script` / `allow_stopping_for_update` block (see full instructions) is
  required so the import doesn't force a recreate.
- Backend `prefix` **must** be exactly `terraform/state`.
- Network module **must** be `10.0.0` — other versions break.
- All **three** instances must be `e2-standard-2` in Task 4 (not just the new one).
- Task 7 `network` arg: use the id/self_link form `projects/PROJECT_ID/global/networks/VPC Name`
  (or reference the module's network output).
- `plan` + `apply` after **each** task before clicking Check my progress.

## Final artifacts (commit here after)

<!-- copy final main.tf, variables.tf, modules/**, + a short writeup -->
- Assigned region / zone / project_id:
- Bucket / 3rd-instance / VPC names:
- Badge URL:
