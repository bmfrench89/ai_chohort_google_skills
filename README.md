# Implement DevOps Workflows in Google Cloud

Coursework repo for the **[Implement DevOps Workflows in Google Cloud](https://www.skills.google/course_templates/716)**
skill badge (Google Cloud Skills Boost), completed as part of an AI cohort.

The labs themselves run in the Google Cloud console (temporary Qwiklabs projects).
This repo tracks the **artifacts and notes** produced along the way: Dockerfiles,
Cloud Build configs, Kubernetes manifests, and the `gcloud` / `kubectl` commands used.

> [!IMPORTANT]
> Everything here is a **reference template**. The live lab hands you specific project
> IDs, regions, zones, and image names. Reconcile those values against the on-screen
> lab instructions before running anything.

## What the badge validates

| Skill | Google Cloud service | Folder |
|-------|----------------------|--------|
| Source control | Cloud Source Repositories | [`01-cloud-source-repos/`](01-cloud-source-repos/) |
| Container orchestration | Google Kubernetes Engine (GKE) | [`02-gke-orchestration/`](02-gke-orchestration/) |
| CI/CD automation | Cloud Build + Artifact Registry | [`03-cicd-cloud-build/`](03-cicd-cloud-build/) |
| **Assessment** | Challenge Lab (GSP330) | [`challenge-lab/`](challenge-lab/) |

## Progress tracker

- [ ] Lab 1 — Cloud Source Repositories *(skipped — fast-tracked to the challenge)*
- [ ] Lab 2 — Managing Deployments Using Kubernetes Engine *(skipped)*
- [ ] Lab 3 — GKE Pipeline using Cloud Build *(skipped)*
- [x] **Challenge Lab (GSP330)** — end-to-end DevOps pipeline ✅ *(2026-07-06)*
- [x] 🎖️ **Badge earned** — see [challenge-lab/COMPLETION.md](challenge-lab/COMPLETION.md)

## Repo layout

```
.
├── 01-cloud-source-repos/     # git + Cloud Source Repositories notes & commands
├── 02-gke-orchestration/      # k8s manifests + deploy/scale/rollout commands
├── 03-cicd-cloud-build/       # sample Go app, Dockerfile, cloudbuild.yaml, manifests
├── challenge-lab/             # GSP330 task checklist + your final artifacts
└── notes/                    # gcloud/kubectl cheatsheet + gotchas
```

## How I use this repo

As I complete each lab I drop the real artifacts I create into the matching folder and
tick the box above. When the badge is done, this gets ported to the company repo for
tracking.
