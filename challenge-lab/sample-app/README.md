# sample-app — completed GSP330 artifacts

The final (v2.0) code and config committed during the GSP330 challenge lab, preserved
here for the cohort/company record. Originally hosted at `bmfrench89/sample-app` and
deployed to GKE via Cloud Build. See [`../COMPLETION.md`](../COMPLETION.md) for the full
run record.

```
sample-app/
├── main.go               # Go web server: /blue and /red endpoints (v2.0)
├── Dockerfile            # multi-stage build → distroless runtime, port 8080
├── cloudbuild.yaml       # PROD pipeline: build → push hello-cloudbuild:v2.0 → deploy to prod ns
├── cloudbuild-dev.yaml   # DEV pipeline:  build → push hello-cloudbuild-dev:v2.0 → deploy to dev ns
├── prod/deployment.yaml  # production-deployment (prod namespace)
└── dev/deployment.yaml   # development-deployment (dev namespace)
```

> Image names embed the lab's project ID (`qwiklabs-gcp-01-a144cb76b171`) and region
> (`us-east1`). To reuse this pipeline elsewhere, swap those plus the cluster/repo names.
