# Challenge Lab — GSP330 (working playbook)

The badge assessment. Full instructions are in
[`GSP330-full-instructions.md`](GSP330-full-instructions.md). This file is our **working
playbook**: the values to capture, the exact edits to make, gotchas, and how we work it
together.

> [!IMPORTANT]
> This lab uses **GitHub Repositories** (`gh` CLI + Cloud Build GitHub App), **not** Cloud
> Source Repositories. The sample code is **provided** via `gs://spls/gsp330/sample-app/*`
> — you don't write the app, you edit placeholders in it.

## How we work it together

1. Launch the lab, open **Cloud Shell**, and keep this chat open beside it.
2. **Paste me the assigned values** (see table below) — I can't see your lab.
3. I hand you exact commands with your values filled in; you run them in Cloud Shell.
4. Paste output/errors back; I troubleshoot and give the next step.
5. Hit **Check my progress** after each task to confirm the grader is happy.

## Values to capture first (paste these to me)

| Placeholder | Where to find it | Yours |
|-------------|------------------|-------|
| `PROJECT_ID` | Lab panel / `gcloud config get-value project` | |
| `REGION` | Lab panel | |
| `ZONE` | Lab panel | |
| GitHub username | from the `gh auth login` step | |

Fixed names the grader expects (don't change these): `my-repository`, `hello-cluster`,
namespaces `prod`/`dev`, repo `sample-app`, triggers `sample-app-prod-deploy` /
`sample-app-dev-deploy`, services `prod-deployment-service` / `dev-deployment-service`.

## Task checklist

- [ ] **Task 1 — Lab resources**: enable APIs · grant Cloud Build `container.developer` ·
      `gh auth login` · Artifact Registry `my-repository` · GKE `hello-cluster` (autoscale
      3/2/6, Regular, v1.29+) · namespaces `prod` + `dev`
- [ ] **Task 2 — GitHub repo**: create empty `sample-app` · clone · `gsutil cp` sample
      code · `sed` region/zone into the cloudbuild files · commit+push `master` · create
      `dev` branch, commit+push
- [ ] **Task 3 — Triggers**: `sample-app-prod-deploy` (`^master$`, `cloudbuild.yaml`) ·
      `sample-app-dev-deploy` (`^dev$`, `cloudbuild-dev.yaml`) via GitHub App
- [ ] **Task 4 — v1.0 deploys**: edit versions + image names (see below) · push dev then
      master · expose both LoadBalancer services · verify `/blue`
- [ ] **Task 5 — v2.0 deploys**: add `redHandler` + update `main()` · bump to v2.0 · push
      dev then master · verify `/red`
- [ ] **Task 6 — Rollback**: rebuild the prod `v1.0` build from Cloud Build History ·
      `/red` should return **404**

## Exact edits the lab requires

The provided sample app ships with placeholders. Confirm line numbers when we inspect the
real files (they should match), then make these edits:

| File | Edit |
|------|------|
| `cloudbuild-dev.yaml` | `<version>` on **lines 9 & 13** → `v1.0` (then `v2.0` in Task 5) |
| `cloudbuild.yaml` | `<version>` on **lines 11 & 16** → `v1.0` (then `v2.0` in Task 5) |
| `dev/deployment.yaml` | `<todo>` on **line 17** → container image name; replace `PROJECT_ID` |
| `prod/deployment.yaml` | `<todo>` on **line 17** → container image name; replace `PROJECT_ID` |
| `main.go` (Task 5) | update `main()` to register `/red`; add `redHandler` func |

**Container image name** (must match between each cloudbuild file and its deployment.yaml).
Artifact Registry format:

```
REGION-docker.pkg.dev/PROJECT_ID/my-repository/IMAGE_NAME:TAG
```

We'll read the exact `IMAGE_NAME` and `:TAG` out of the provided `cloudbuild.yaml` /
`cloudbuild-dev.yaml` when we inspect them, so the deployment image matches exactly.

### Task 5 Go edits (ready to paste)

Update `main()`:

```go
func main() {
	http.HandleFunc("/blue", blueHandler)
	http.HandleFunc("/red", redHandler)
	http.ListenAndServe(":8080", nil)
}
```

Add `redHandler`:

```go
func redHandler(w http.ResponseWriter, r *http.Request) {
	img := image.NewRGBA(image.Rect(0, 0, 100, 100))
	draw.Draw(img, img.Bounds(), &image.Uniform{color.RGBA{255, 0, 0, 255}}, image.ZP, draw.Src)
	w.Header().Set("Content-Type", "image/png")
	png.Encode(w, img)
}
```

## Grader gotchas

- Image path must be **exactly** `REGION-docker.pkg.dev/PROJECT_ID/my-repository/IMAGE:TAG`
  and **identical** in the cloudbuild file and its deployment.yaml.
- Triggers must watch the right branch regex (`^master$` / `^dev$`) and the right config
  file (`cloudbuild.yaml` / `cloudbuild-dev.yaml`).
- Cloud Build SA needs `roles/container.developer` or the deploy step fails.
- Right namespace: prod deploy → `prod` ns, dev deploy → `dev` ns.
- Services are `LoadBalancer`, **port 8080**, target port = the Dockerfile's `EXPOSE`.
- Wait for the Service `EXTERNAL-IP` before curling; v2.0 rollout can take a couple mins.
- Task 6: rollback = **rebuild the old v1.0 prod build** from Cloud Build History; success
  check is `/red` → **404**.

## Final artifacts (commit here as we go)

<!-- copy the edited cloudbuild files, deployment.yaml files, main.go, and a short writeup -->
- Assigned PROJECT_ID / REGION / ZONE:
- Image name used:
- Build IDs (v1.0 dev, v1.0 prod, v2.0 dev, v2.0 prod, rollback):
- Service external IPs:
- Badge URL: https://www.skills.google/public_profiles/6a99762d-bfb2-4e65-b273-58cbdefb9784/badges/25359987
