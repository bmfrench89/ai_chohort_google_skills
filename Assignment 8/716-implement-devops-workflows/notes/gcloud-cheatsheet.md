# gcloud / kubectl cheatsheet

Commands reused across the labs. Replace `PROJECT_ID`, zone, and names as needed.

## Config & auth

```bash
gcloud config set project PROJECT_ID
gcloud config set compute/zone us-central1-c
gcloud config list
gcloud auth list
```

## Enable APIs

```bash
gcloud services enable \
  container.googleapis.com \
  cloudbuild.googleapis.com \
  artifactregistry.googleapis.com \
  sourcerepo.googleapis.com
```

## Cloud Source Repositories

```bash
gcloud source repos create sample-app
gcloud source repos list
gcloud source repos clone sample-app
```

## Artifact Registry

```bash
gcloud artifacts repositories create my-repository \
  --repository-format=docker --location=us-central1

gcloud artifacts repositories list
gcloud artifacts docker images list us-central1-docker.pkg.dev/PROJECT_ID/my-repository
```

## GKE clusters

```bash
gcloud container clusters create hello-cluster --num-nodes=3
gcloud container clusters get-credentials hello-cluster
gcloud container clusters list
gcloud container clusters delete hello-cluster
```

## kubectl basics

```bash
kubectl apply -f manifests/
kubectl get deployments,pods,services
kubectl describe deployment hello-app
kubectl logs -l app=hello-app --tail=50

# scaling
kubectl scale deployment hello-app --replicas=5
kubectl autoscale deployment hello-app --cpu-percent=60 --min=3 --max=10

# rollouts
kubectl set image deployment/hello-app hello-app=IMAGE:TAG
kubectl rollout status deployment/hello-app
kubectl rollout history deployment/hello-app
kubectl rollout undo deployment/hello-app
```

## Cloud Build

```bash
# Manual build from a cloudbuild.yaml
gcloud builds submit --config cloudbuild.yaml --substitutions=SHORT_SHA=manual

gcloud builds list --limit=5
gcloud builds log BUILD_ID

# Trigger on push to master of a CSR repo
gcloud builds triggers create cloud-source-repositories \
  --repo=sample-app --branch-pattern='^master$' \
  --build-config=cloudbuild.yaml --name=sample-app-trigger

gcloud builds triggers list
```

## IAM (let Cloud Build deploy to GKE)

```bash
PROJECT_NUMBER=$(gcloud projects describe PROJECT_ID --format='value(projectNumber)')
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com" \
  --role="roles/container.developer"
```
