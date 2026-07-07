# AI Cohort — Google Cloud Skill Badges

Coursework repo tracking Google Cloud skill badges completed for an AI cohort. Each course
lives in its own top-level directory holding its labs, notes, challenge-lab artifacts, and a
completion record.

> The labs run in the Google Cloud console (temporary Qwiklabs projects). This repo tracks
> the **artifacts and notes** — Terraform/YAML configs, Dockerfiles, pipeline definitions,
> and `gcloud`/`terraform` commands — produced along the way.

## Folder naming convention

Top-level course folders are named **`<template#>-<slug>`**, where `<template#>` is the
Google Skills course template ID from its URL
(`https://www.skills.google/course_templates/<template#>`). Example:
`716-implement-devops-workflows/` ↔ `course_templates/716`.

## Courses

| Template | Course | Status | Folder |
|----------|--------|--------|--------|
| [716](https://www.skills.google/course_templates/716) | Implement DevOps Workflows in Google Cloud | ✅ **Badge earned** (2026-07-06) | [`716-implement-devops-workflows/`](716-implement-devops-workflows/) |
| [636](https://www.skills.google/course_templates/636) | Build Infrastructure with Terraform on Google Cloud | ✅ **Badge earned** (2026-07-06) | [`636-build-infrastructure-terraform/`](636-build-infrastructure-terraform/) |

## Layout

```
.
├── 716-implement-devops-workflows/        # GSP330 — GKE + Cloud Build + GitHub CI/CD
│   ├── 01-cloud-source-repos/
│   ├── 02-gke-orchestration/
│   ├── 03-cicd-cloud-build/
│   ├── challenge-lab/                      # completed artifacts + COMPLETION.md
│   └── notes/
├── 636-build-infrastructure-terraform/    # GSP345 — Terraform IaC on Google Cloud
│   ├── reference/                          # reference .tf templates (provider, module, backend)
│   ├── challenge-lab/                      # filled in when the challenge lab is run
│   └── notes/
└── .gitignore
```

## Badges earned

- 🎖️ [Implement DevOps Workflows in Google Cloud](https://www.skills.google/public_profiles/6a99762d-bfb2-4e65-b273-58cbdefb9784/badges/25359987) — Jul 6, 2026
- 🎖️ Build Infrastructure with Terraform on Google Cloud — Jul 6, 2026

Public profile: https://www.skills.google/public_profiles/6a99762d-bfb2-4e65-b273-58cbdefb9784
