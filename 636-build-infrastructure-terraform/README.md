# Build Infrastructure with Terraform on Google Cloud

Coursework for the **[Build Infrastructure with Terraform on Google Cloud](https://www.skills.google/course_templates/636)**
skill badge (Google Cloud Skills Boost) — Intermediate, ~1h45m.

The challenge lab for this badge is **GSP345** — *Build Infrastructure with Terraform on
Google Cloud: Challenge Lab*. (Task list gets filled into [`challenge-lab/`](challenge-lab/)
once the lab is launched and its exact assigned values are known.)

> [!IMPORTANT]
> Everything here is a **reference template**. The live lab hands you specific project IDs,
> regions, bucket names, and instance names. Reconcile those against the on-screen lab
> instructions before running `terraform apply`.

## What the badge validates

| Skill | What it means | Where |
|-------|---------------|-------|
| Provisioning | Define and create Google Cloud resources as code | [`reference/main.tf`](reference/main.tf) |
| State management | Local vs. remote state (GCS backend) | [`reference/backend.tf`](reference/backend.tf) |
| Modularization | Reusable modules with inputs/outputs | [`reference/modules/instance/`](reference/modules/instance/) |

Plus challenge-lab skills: `terraform import` (bring existing infra under management),
`terraform taint`/`-replace`, and pulling a module from the Terraform Registry.

## Progress tracker

- [ ] Challenge Lab (GSP345) — build/import/modularize infrastructure with Terraform
- [ ] 🎖️ Badge earned

## Layout

```
course-02-terraform-infrastructure/
├── reference/                 # correct .tf templates to compare against
│   ├── main.tf                #   provider + a module call + a storage bucket
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   ├── backend.tf             #   remote GCS backend (commented example)
│   └── modules/instance/      #   a reusable Compute Engine module
├── challenge-lab/             # GSP345 playbook + your final .tf artifacts
└── notes/                     # terraform command cheatsheet
```

## Core workflow (every Terraform lab)

```bash
terraform init       # download providers, set up backend
terraform fmt        # format
terraform validate   # check config
terraform plan       # preview changes
terraform apply      # create/update resources
terraform destroy    # tear down
```

See [`notes/terraform-cheatsheet.md`](notes/terraform-cheatsheet.md) for import/taint/state
commands used in the challenge lab.
