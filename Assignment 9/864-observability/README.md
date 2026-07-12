# Course 2 — Observability in Google Cloud

[`course_templates/864`](https://www.cloudskillsboost.google/course_templates/864) · supports **L9.1, L9.4** · **30 pts** of the assignment.

One guided lab focused on distributed tracing.

## Lab

### View application latency with Cloud Trace — 30 pts (L9.1 · L9.4)
Trace a request as it moves **across services** (GKE-hosted `cloud-trace-demo-a/b/c`), then
**locate the latency bottleneck** with Cloud Trace.
- [x] **Completed 2026-07-12 · 30/30** — GKE cluster + 3 OpenTelemetry services deployed, traces created, spans viewed in Trace Explorer. Shots in [`screenshots/01-view-application-latency-with-cloud-trace/`](screenshots/01-view-application-latency-with-cloud-trace/)

## Notes / gotchas

- **Zone org policy:** `us-west1` was blocked → used **`us-east1-b`** (found allowed zones via `gcloud resource-manager org-policies describe gcp.resourceLocations --effective`).
- **"Check my progress" has no CLI** — it's the Qwiklabs grader button; must be clicked in the lab UI. Generating traces (curl) and verifying them (Trace API) are both CLI-able.

## Evidence
Screenshots → [`screenshots/`](screenshots/).
Course 2 badge URL (if awarded): _add to [../submission.md](../submission.md)_
