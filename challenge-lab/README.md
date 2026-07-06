# Challenge Lab — Implement DevOps Workflows in Google Cloud (GSP330)

The badge assessment. No step-by-step hand-holding — you're given goals and must apply
the three skills end to end. This is a **task checklist** to work through; drop your final
artifacts (the actual `cloudbuild.yaml`, `Dockerfile`, and manifests you commit) into this
folder as you go.

> [!WARNING]
> The live challenge lab specifies exact names (Artifact Registry repo, cluster,
> region/zone, image, trigger). **Use the names the lab gives you**, not the placeholders
> here — the auto-grader checks for its specific names.

## Typical task flow

- [ ] **Task 1 — Create the lab resources**
  - Enable APIs: `container`, `cloudbuild`, `artifactregistry`, `sourcerepo`.
  - Create an Artifact Registry Docker repo (lab names it, often `my-repository`) in the
    given region.
- [ ] **Task 2 — Create the Cloud Source Repository**
  - Create a repo (often `sample-app`) and copy the provided sample code into it.
  - Commit and push to `master`.
- [ ] **Task 3 — Build & test the first image**
  - Build with Cloud Build, tag `:v1.0`, push to Artifact Registry.
  - Create the GKE cluster (lab names it, e.g. `hello-cluster`).
  - Create `prod` and `dev` namespaces if the lab asks.
  - Deploy and confirm it responds.
- [ ] **Task 4 — Create the Cloud Build trigger**
  - Trigger on push to `master` of the source repo, using `cloudbuild.yaml`.
  - Grant Cloud Build the `roles/container.developer` IAM role.
- [ ] **Task 5 — Deploy a change through the pipeline**
  - Edit the app (bump the version string), commit, push.
  - Confirm the trigger fires, a new image builds with `$SHORT_SHA`, and GKE rolls out
    the new version.

## Reference artifacts

The working templates in [`../03-cicd-cloud-build/sample-app/`](../03-cicd-cloud-build/sample-app/)
match this flow (Go app + Dockerfile + `cloudbuild.yaml` + `kubernetes/`). Copy them here
and adjust names once you know the lab's required values.

## Common grader gotchas

- Image path must be **exactly** `REGION-docker.pkg.dev/PROJECT_ID/REPO/IMAGE:TAG`.
- The trigger must watch the **right branch** (`^master$`) and point at `cloudbuild.yaml`.
- Cloud Build's service account needs `roles/container.developer` or the deploy step fails.
- Wait for the GKE Service `EXTERNAL-IP` to be assigned before curling it.

## Final artifacts (commit here)

<!-- drop your real cloudbuild.yaml, Dockerfile, manifests, and a short writeup -->
- Lab-assigned names used:
- Screenshot / build ID of the successful auto-deploy:
- Badge URL:
