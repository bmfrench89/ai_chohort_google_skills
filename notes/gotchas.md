# Gotchas & lessons learned

Running log of things that tripped me up. Add to this as you go — it's the most useful
part of the repo when you (or a teammate) redo this later.

## Environment

- **Qwiklabs projects are temporary.** Everything is wiped when the lab ends. Copy any
  artifact you want to keep into this repo *before* clicking "End Lab".
- **Use the lab's exact names.** The auto-grader checks specific repo/cluster/image names.
  Placeholder names in this repo will fail grading.
- **Regions vs. zones.** Artifact Registry and clusters take a *region* (`us-central1`);
  some `gcloud container` commands take a *zone* (`us-central1-c`). Mixing them up is a
  common failure.

## Cloud Build

- Cloud Build's service account (`PROJECT_NUMBER@cloudbuild.gserviceaccount.com`) needs
  `roles/container.developer` to deploy to GKE, or the deploy step errors with a
  permissions failure.
- `$SHORT_SHA` is only populated on trigger-driven builds. For a manual
  `gcloud builds submit`, pass `--substitutions=SHORT_SHA=manual` or the tag is empty.
- If a build can't push, check the image path is `REGION-docker.pkg.dev/...`, not the old
  `gcr.io/...` Container Registry path.

## GKE

- `kubectl` commands fail until you run `gcloud container clusters get-credentials`.
- `Service` `EXTERNAL-IP` shows `<pending>` for a minute or two while the load balancer
  provisions — wait before curling it.
- Readiness probe path must actually return 200, or pods never become Ready and the
  rollout appears stuck.

## <add your own>

-
