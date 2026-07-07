# GSP330 — Implement DevOps Workflows in Google Cloud: Challenge Lab

> Full lab instructions, captured verbatim for reference. Manual last updated May 20, 2026.
> **Uses GitHub Repositories** (via the `gh` CLI + Cloud Build GitHub App) — *not* Cloud
> Source Repositories.

## Overview

In a challenge lab you're given a scenario and a set of tasks. Instead of following
step-by-step instructions, you use the skills learned in the course to complete the tasks
on your own. An automated scoring system provides feedback. To score 100% you must
complete all tasks within the time period.

## Prerequisites

- A **GitHub account** is required. Create one beforehand if you don't have it.
- Use an **Incognito / private browser window** and the **student account** only.

## Challenge scenario

DevOps Engineer for **Cymbal Superstore**. The DevOps team wants a large-scale CI/CD
pipeline using **all native Google Cloud services**. Demonstrate skills with GitHub,
Artifact Registry, Docker, and Cloud Build.

Tasks:
- Create a GKE cluster from a set of configurations.
- Create a GitHub repository to host the Go application code.
- Create Cloud Build triggers that deploy a production and a development application.
- Push updates to the app and create new builds.
- Roll back the production application to a previous version.

---

## Task 1. Create the lab resources

Enable the APIs for GKE and Cloud Build:

```bash
gcloud services enable container.googleapis.com \
    cloudbuild.googleapis.com
```

Add the Kubernetes Developer role for the Cloud Build service account:

```bash
export PROJECT_ID=$(gcloud config get-value project)
gcloud projects add-iam-policy-binding $PROJECT_ID \
--member=serviceAccount:$(gcloud projects describe $PROJECT_ID \
--format="value(projectNumber)")@cloudbuild.gserviceaccount.com --role="roles/container.developer"
```

Configure Git and GitHub in Cloud Shell:

```bash
curl -sS https://webi.sh/gh | sh
gh auth login
gh api user -q ".login"
GITHUB_USERNAME=$(gh api user -q ".login")
git config --global user.name "${GITHUB_USERNAME}"
git config --global user.email "${USER_EMAIL}"
echo ${GITHUB_USERNAME}
echo ${USER_EMAIL}
```

- Press ENTER to accept the default options.
- Follow the output instructions to log in to GitHub with a web browser.
- On success your GitHub username appears in the Cloud Shell output.

Create an **Artifact Registry Docker repository** named `my-repository` in the **REGION**
region to store container images.

Create a **GKE Standard cluster** named `hello-cluster` with this configuration:

| Setting | Value |
|---------|-------|
| Zone | ZONE |
| Release channel | Regular |
| Cluster version | 1.29 or newer |
| Cluster autoscaler | Enabled |
| Number of nodes | 3 |
| Minimum nodes | 2 |
| Maximum nodes | 6 |

Create the `prod` and `dev` namespaces on the cluster.

> **Check my progress** → *Create the lab resources*

---

## Task 2. Create a repository in GitHub Repositories

Create a repository `sample-app` in GitHub and initialize it with sample code. This repo
holds the Go application code and is the primary source for triggering builds.

- Create an **empty repository** named `sample-app` in GitHub.
- Clone the `sample-app` GitHub repository in Cloud Shell.
- Copy the sample code into the `sample-app` directory:

```bash
cd ~
gsutil cp -r gs://spls/gsp330/sample-app/* sample-app
```

- Replace the `<your-region>` and `<your-zone>` placeholders in `cloudbuild-dev.yaml` and
  `cloudbuild.yaml` with the assigned region and zone:

```bash
export REGION="REGION"
export ZONE="ZONE"
for file in sample-app/cloudbuild-dev.yaml sample-app/cloudbuild.yaml; do
    sed -i "s/<your-region>/${REGION}/g" "$file"
    sed -i "s/<your-zone>/${ZONE}/g" "$file"
done
```

- Make your first commit with the sample code and push to the **`master`** branch.
- Create a branch named **`dev`**. Commit the sample code and push to the `dev` branch.
- Verify the sample code and both branches are stored in the GitHub repository.

The Go application has two entry points: **Red** and **Blue**. Each displays a colored
square on the web page depending on the entry point.

---

## Task 3. Create the Cloud Build Triggers

Two triggers:
- **master branch** → build Docker image, push to Artifact Registry, deploy to **prod**
  namespace.
- **dev branch** → build Docker image, push to Artifact Registry, deploy to **dev**
  namespace.

Create a Cloud Build Trigger named **`sample-app-prod-deploy`**:

- **Event:** Push to a branch
- **Source:** Connect to a new repository → source provider: **GitHub (Cloud Build GitHub App)**
- **Repository:** `sample-app`
- **Branch:** `^master$`
- **Cloud Build Configuration File:** `cloudbuild.yaml`

Create a Cloud Build Trigger named **`sample-app-dev-deploy`**:

- **Event:** Push to a branch
- **Repository:** `sample-app`
- **Branch:** `^dev$`
- **Cloud Build Configuration File:** `cloudbuild-dev.yaml`

> **Check my progress** → *Create the Cloud Build Triggers*

---

## Task 4. Deploy the first versions of the application

### Build the first development deployment

- Inspect `cloudbuild-dev.yaml` in the `sample-app` directory. Replace `<version>` on
  **lines 9 and 13** with **`v1.0`**.
- In `dev/deployment.yaml`, update the `<todo>` on **line 17** with the correct container
  image name. Replace the `PROJECT_ID` variable with the actual project ID in the image
  name.
  - **Note:** the container image name must match between `dev/deployment.yaml` and
    `cloudbuild-dev.yaml`.
- Commit on the `dev` branch and push to trigger `sample-app-dev-deploy`.
- Verify the build succeeded (Cloud Build History) and `development-deployment` was
  deployed to the `dev` namespace.
- Expose `development-deployment` to a **LoadBalancer** service named
  **`dev-deployment-service`** on **port 8080**, target port = the one in the Dockerfile.
- Browse to the LB IP + `/blue` (e.g. `http://34.135.97.199:8080/blue`) to verify.

### Build the first production deployment

- Switch to the `master` branch. Inspect `cloudbuild.yaml`. Replace `<version>` on
  **lines 11 and 16** with **`v1.0`**.
- In `prod/deployment.yaml`, update the `<todo>` on **line 17** with the correct container
  image name. Replace `PROJECT_ID` with the actual project ID.
  - **Note:** image name must match between `prod/deployment.yaml` and `cloudbuild.yaml`.
- Commit on `master` and push to trigger `sample-app-prod-deploy`.
- Verify the build succeeded and `production-deployment` was deployed to the `prod`
  namespace.
- Expose `production-deployment` (prod namespace) to a **LoadBalancer** service named
  **`prod-deployment-service`** on **port 8080**, target port from the Dockerfile.
- Browse to the LB IP + `/blue` (e.g. `http://34.135.245.19:8080/blue`) to verify.

> **Check my progress** → *Deploy the first versions of the application*

---

## Task 5. Deploy the second versions of the application

### Build the second development deployment

- Switch back to the **`dev`** branch. (Make sure you're on `dev` before proceeding.)
- In `main.go`, update `main()` to:

```go
func main() {
	http.HandleFunc("/blue", blueHandler)
	http.HandleFunc("/red", redHandler)
	http.ListenAndServe(":8080", nil)
}
```

- Add this function inside `main.go`:

```go
func redHandler(w http.ResponseWriter, r *http.Request) {
	img := image.NewRGBA(image.Rect(0, 0, 100, 100))
	draw.Draw(img, img.Bounds(), &image.Uniform{color.RGBA{255, 0, 0, 255}}, image.ZP, draw.Src)
	w.Header().Set("Content-Type", "image/png")
	png.Encode(w, img)
}
```

- Inspect `cloudbuild-dev.yaml`. Update the Docker image version to **`v2.0`**.
- In `dev/deployment.yaml`, update the container image name to the new version (`v2.0`).
- Commit on `dev` and push to trigger `sample-app-dev-deploy`.
- Verify the build succeeded and `development-deployment` is using the `v2.0` image.
- Browse to the LB IP + `/red` (e.g. `http://34.135.97.199:8080/red`) to verify.
  - *May take a couple of minutes to propagate to the load balancer.*

### Build the second production deployment

- Switch to the **`master`** branch. (Make sure you're on `master` before proceeding.)
- In `main.go`, update `main()` to:

```go
func main() {
	http.HandleFunc("/blue", blueHandler)
	http.HandleFunc("/red", redHandler)
	http.ListenAndServe(":8080", nil)
}
```

- Add this function inside `main.go`:

```go
func redHandler(w http.ResponseWriter, r *http.Request) {
	img := image.NewRGBA(image.Rect(0, 0, 100, 100))
	draw.Draw(img, img.Bounds(), &image.Uniform{color.RGBA{255, 0, 0, 255}}, image.ZP, draw.Src)
	w.Header().Set("Content-Type", "image/png")
	png.Encode(w, img)
}
```

- Inspect `cloudbuild.yaml`. Update the Docker image version to **`v2.0`**.
- In `prod/deployment.yaml`, update the container image name to the new version (`v2.0`).
- Commit on `master` and push to trigger `sample-app-prod-deploy`.
- Verify the build succeeded and `production-deployment` is using the `v2.0` image.
- Browse to the LB IP + `/red` (e.g. `http://34.135.245.19:8080/red`) to verify.
  - *May take a couple of minutes to propagate.*

> **Check my progress** → *Deploy the second versions of the application*

---

## Task 6. Roll back the production deployment

- Roll back `production-deployment` to use the **`v1.0`** version of the application.
  - **Hint:** using Cloud Build History, you can easily rebuild/rollback a previous build.
- Browse to the LB IP + `/red` of the production deployment — the response should be
  **404** (because v1.0 has no `/red` endpoint).

> **Check my progress** → *Roll back the production deployment*

---

## Key facts summary

| Item | Value |
|------|-------|
| Artifact Registry repo | `my-repository` (Docker, in **REGION**) |
| GKE cluster | `hello-cluster` (Standard, zone **ZONE**, Regular channel, v1.29+, autoscale 3 nodes / min 2 / max 6) |
| Namespaces | `prod`, `dev` |
| GitHub repo | `sample-app` (branches: `master`, `dev`) |
| Sample code source | `gs://spls/gsp330/sample-app/*` |
| Prod trigger | `sample-app-prod-deploy` → `^master$` → `cloudbuild.yaml` → prod ns |
| Dev trigger | `sample-app-dev-deploy` → `^dev$` → `cloudbuild-dev.yaml` → dev ns |
| Prod service | `prod-deployment-service` (LoadBalancer, port 8080) |
| Dev service | `dev-deployment-service` (LoadBalancer, port 8080) |
| Deployments | `production-deployment` (prod ns), `development-deployment` (dev ns) |
| App endpoints | `/blue` (v1.0+), `/red` (added in v2.0) |
