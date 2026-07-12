# Lab 3 — GKE Pipeline using Cloud Build

**Skill:** architect a CI/CD pipeline that automatically **builds a container image** and
**deploys it to GKE** whenever code is pushed. This ties together everything: code in
Cloud Source Repositories → Cloud Build trigger → image in Artifact Registry → rollout
on GKE.

> Reference artifacts — swap `PROJECT_ID`, region, repository, and cluster names for the
> live lab values.

## Sample app

[`sample-app/`](sample-app/) is a tiny Go web server that prints its version, so you can
see the pipeline deliver a change end to end:

```
sample-app/
├── main.go             # HTTP server, prints "Version: x.y.z"
├── go.mod
├── Dockerfile          # multi-stage build → small runtime image
├── .dockerignore
├── cloudbuild.yaml     # build → push to Artifact Registry → deploy to GKE
└── kubernetes/
    ├── deployment.yaml
    └── service.yaml
```

## One-time setup

```bash
gcloud config set project PROJECT_ID
gcloud config set compute/zone us-central1-c

# Enable required APIs
gcloud services enable \
  container.googleapis.com \
  cloudbuild.googleapis.com \
  artifactregistry.googleapis.com \
  sourcerepo.googleapis.com

# Artifact Registry Docker repo to hold images
gcloud artifacts repositories create my-repository \
  --repository-format=docker \
  --location=us-central1 \
  --description="Docker images for the DevOps badge"

# GKE cluster to deploy into
gcloud container clusters create hello-cluster --num-nodes=3
gcloud container clusters get-credentials hello-cluster
```

## Grant Cloud Build permission to deploy to GKE

Cloud Build needs the **Kubernetes Engine Developer** role to apply manifests:

```bash
PROJECT_NUMBER=$(gcloud projects describe PROJECT_ID --format='value(projectNumber)')
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com" \
  --role="roles/container.developer"
```

## Manual build (test the pipeline once)

```bash
cd sample-app
gcloud builds submit --config cloudbuild.yaml \
  --substitutions=SHORT_SHA=manual
```

## Automate with a trigger

Create a Cloud Build trigger on push to `master` of the `sample-app` repo:

```bash
gcloud builds triggers create cloud-source-repositories \
  --repo=sample-app \
  --branch-pattern='^master$' \
  --build-config=cloudbuild.yaml \
  --name=sample-app-trigger
```

Then edit `main.go` (bump the version), commit, and `git push origin master`. Watch
**Cloud Build → History** run automatically and the new version roll out on GKE.

## Verify

```bash
kubectl get pods
kubectl get service hello-app     # curl the EXTERNAL-IP to see the version string
```

## Notes / what I actually did

- Artifact Registry repo / region:
- Cluster name:
- Trigger name:
- Version bump result:
