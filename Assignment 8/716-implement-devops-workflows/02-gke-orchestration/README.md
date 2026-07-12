# Lab 2 — Managing Deployments Using Kubernetes Engine

**Skill:** launch, manage, scale, and roll out Deployments on GKE. This lab covers the
core Deployment operations: creating a cluster, applying manifests, scaling replicas,
performing a rolling update, and running a canary.

> Reference commands — swap zone/region, cluster name, and image for the lab's values.

Manifests live in [`manifests/`](manifests/):
- `deployment.yaml` — a 3-replica Deployment
- `service.yaml` — a LoadBalancer Service exposing it
- `hpa.yaml` — a HorizontalPodAutoscaler for automatic scaling

## Create a cluster

```bash
gcloud config set compute/zone us-central1-c
gcloud container clusters create bootcamp \
  --machine-type e2-small \
  --num-nodes 3

# Wire kubectl to the new cluster
gcloud container clusters get-credentials bootcamp
```

## Deploy

```bash
kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml

kubectl get deployments
kubectl get pods
kubectl get service hello-app   # wait for EXTERNAL-IP
```

## Scale

```bash
# Manual scale
kubectl scale deployment hello-app --replicas=5
kubectl get pods

# Autoscale (or apply manifests/hpa.yaml)
kubectl autoscale deployment hello-app --cpu-percent=60 --min=3 --max=10
kubectl get hpa
```

## Rolling update

```bash
# Change the image (triggers a rolling update)
kubectl set image deployment/hello-app hello-app=hello-app:2.0.0

# Watch it roll out
kubectl rollout status deployment/hello-app
kubectl rollout history deployment/hello-app

# Roll back if needed
kubectl rollout undo deployment/hello-app
```

## Canary (optional in this lab)

Run a second Deployment with fewer replicas sharing the same Service selector label so a
fraction of traffic hits the new version. See `manifests/deployment.yaml` for the label
pattern (`app: hello-app`).

## Cleanup

```bash
kubectl delete -f manifests/
gcloud container clusters delete bootcamp
```

## Notes / what I actually did

- Cluster name / zone:
- Scaling results observed:
- Rollout / rollback notes:
