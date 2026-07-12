# GSP345 — Build Infrastructure with Terraform on Google Cloud: Challenge Lab

> Full lab instructions, captured verbatim for reference. **30 minutes**, 5 credits,
> Intermediate. Updated ~2026-07.

## Topics tested

- Import existing infrastructure into your Terraform configuration.
- Build and reference your own Terraform modules.
- Add a remote backend to your configuration.
- Use and implement a module from the Terraform Registry.
- Re-provision, destroy, and update infrastructure.
- Test connectivity between the resources you've created.

## Challenge scenario

Cloud engineer intern at a startup. Use Terraform to create/deploy/track infrastructure on
Google Cloud, and import some mismanaged instances and fix them. You will import and create
multiple VM instances, a VPC network with two subnetworks, and a firewall rule allowing
connections between the two instances. You will also create a Cloud Storage bucket to host
your remote backend.

> **At the end of every section, `terraform plan` and `terraform apply`** so your work can be
> verified. Many files get updated — mind the file paths and indentation.

## Lab-assigned values to capture (grader checks these exactly)

| Placeholder in instructions | Where to get it |
|-----------------------------|-----------------|
| `region` default | lab / assigned |
| `zone` default | lab ("filled in at lab start") |
| `project_id` | your Google Cloud project ID |
| **Bucket Name** | lab-assigned (Task 3) |
| **Instance Name** (the 3rd instance) | lab-assigned (Task 4) |
| **VPC Name** | lab-assigned (Task 6) |

---

## Prerequisite — install Terraform (not pre-installed in Cloud Shell)

Run in Cloud Shell (persists across sessions via `~/.customize_environment`):

```bash
cat <<'EOF' > ~/.customize_environment
# Set up HashiCorp repository and install Terraform
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install -y terraform
EOF
bash ~/.customize_environment
```

Verify (expect v1.5.7 or later):

```bash
terraform --version
```

---

## Task 1. Create the configuration files

Create this directory structure in Cloud Shell:

```
main.tf
variables.tf
modules/
└── instances
    ├── instances.tf
    ├── outputs.tf
    └── variables.tf
└── storage
    ├── storage.tf
    ├── outputs.tf
    └── variables.tf
```

- Fill out the `variables.tf` files (root **and** each module) with three variables:
  `region`, `zone`, `project_id`. Defaults: region + zone from the lab, `project_id` = your
  project ID. Use these variables anywhere applicable in resource configs.
- Add the **Terraform block** and the **Google Provider** to `main.tf`. The provider block must
  include `zone` along with `project` and `region`.
- Initialize Terraform (`terraform init`).

## Task 2. Import infrastructure

Two instances `tf-instance-1` and `tf-instance-2` already exist (Compute Engine → VM
Instances). Click one to find its Instance ID, boot disk image, and machine type.

Import both into the **instances module**:
1. Add the module reference to `main.tf`, then re-init Terraform.
2. Write resource configs in `instances.tf` matching the pre-existing instances. Name them
   `tf-instance-1` and `tf-instance-2`. Keep it minimal — only these arguments:
   `machine_type`, `boot_disk`, `network_interface`, `metadata_startup_script`,
   `allow_stopping_for_update`. Use exactly:

   ```hcl
   metadata_startup_script = <<-EOT
           #!/bin/bash
       EOT
   allow_stopping_for_update = true
   ```
3. `terraform import` each into the instances module.
4. `terraform apply` — it updates the instances in-place (expected).

> **Check my progress** → *Import infrastructure.*

## Task 3. Configure a remote backend

- Create a `google_storage_bucket` resource **inside the storage module**. Bucket name =
  **Bucket Name**. Other args:

  ```hcl
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
  ```
  (Optional: outputs in `outputs.tf`.)
- Add the storage module reference to `main.tf`, init, and apply to create the bucket.
- Configure this bucket as the **remote backend** in `main.tf`. Use **`prefix = "terraform/state"`**
  (required for grading).
- On `terraform init`, answer **yes** to copy existing state to the new backend.

> **Check my progress** → *Configure a remote backend.*

## Task 4. Modify and update infrastructure

- Change `tf-instance-1` and `tf-instance-2` to machine type **`e2-standard-2`**.
- Add a **third** instance named **Instance Name**, also **`e2-standard-2`**. (All three must
  be `e2-standard-2`.)
- Init and apply.

> **Check my progress** → *Modify and update infrastructure.*

## Task 5. Destroy resources

- Remove the third instance (**Instance Name**) from the config, then init and apply.

> **Check my progress** → *Destroy resources.*

## Task 6. Use a module from the Registry

Add the **Network module** from the Terraform Registry to `main.tf`:
- **Version `10.0.0`** (other versions may break compatibility).
- VPC name = **VPC Name**, **global** routing mode.
- **2 subnets** in the region, named `subnet-01` and `subnet-02` (only Name, IP, Region args).
  - `subnet-01` → `10.10.10.0/24`
  - `subnet-02` → `10.10.20.0/24`
  - Omit secondary ranges and routes.
- Init and apply to create the networks.
- In `instances.tf`, connect `tf-instance-1` → `subnet-01`, `tf-instance-2` → `subnet-02`:
  set each instance's `network` = **VPC Name** and add a `subnetwork` argument with the right
  subnet.

> **Check my progress** → *Use a module from the Registry.*

## Task 7. Configure a firewall

- Create a firewall rule in `main.tf` named **`tf-firewall`**.
- Permit the **VPC Name** network to allow **ingress** on all ranges (`0.0.0.0/0`), **TCP port 80**.
- Include `source_ranges = ["0.0.0.0/0"]`.
- The `network` argument: inspect state for the `google_compute_network` ID / self_link — form
  `projects/PROJECT_ID/global/networks/VPC Name`.
- Init and apply.

> **Check my progress** → *Configure a firewall.*
