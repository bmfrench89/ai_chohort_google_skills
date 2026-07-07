# GSP330 — Screenshot walkthrough

Visual evidence captured while completing the challenge lab on 2026-07-06, in order.

> **To populate:** save each screenshot below into this folder using the listed filename.
> They'll then render inline here and be tracked in the repo. (Claude could not export the
> images pasted into the chat session, so these need to be added from your saved copies.)

| # | Filename | Task | What it shows |
|---|----------|------|---------------|
| 01 | `01-github-signup.png` | 2 | GitHub "Sign up" page (the account fork — chose real account over the throwaway) |
| 02 | `02-github-suspended.png` | 2 | GitHub sign-in showing the (stale) account-suspended banner |
| 03 | `03-artifact-registry.png` | 1 | Artifact Registry — `my-repository` (Docker, us-east1) created |
| 04 | `04-gke-cluster-provisioning.png` | 1 | Kubernetes Engine — `hello-cluster` provisioning (3 nodes, us-east1-b) |
| 05 | `05-trigger-advanced-sa.png` | 3 | Create trigger → Advanced (approval + required service account) |
| 06 | `06-service-account-dropdown.png` | 3 | Service account picker — selected the Owner user-managed SA |
| 07 | `07-install-github-app.png` | 3 | Connect repo → Install Google Cloud Build GitHub App |
| 08 | `08-build-history-dev-v1.png` | 4 | Cloud Build History — dev v1.0 build (`4aedc7ee`) running |
| 09 | `09-dev-v1-blue.png` | 4 | Dev `/blue` → blue square (`104.196.161.203:8080/blue`) |
| 10 | `10-build-history-prod-v1.png` | 4 | Cloud Build History — prod v1.0 build (`d633aab0`) running |
| 11 | `11-build-history-dev-v2.png` | 5 | Cloud Build History — dev v2.0 build (`1649fe9c`) running |
| 12 | `12-dev-v2-red.png` | 5 | Dev `/red` → red square (`104.196.161.203:8080/red`) |
| 13 | `13-build-history-prod-v2.png` | 5 | Cloud Build History — prod v2.0 build (`4d84ec25`) running |
| 14 | `14-prod-v2-red.png` | 5 | Prod `/red` → red square (`104.196.190.49:8080/red`) |
| 15 | `15-retry-build-rollback.png` | 6 | Build details for `d633aab0` — "Retry build" (rollback to v1.0) |
| 16 | `16-prod-rollback-404.png` | 6 | Prod `/red` → `404 page not found` after rollback |
| 17 | `17-badge-earned.png` | — | Google Skills badge: "Implement DevOps Workflows in Google Cloud" |

Once the files are in this folder, they can be embedded like:

```markdown
![Dev /blue → blue square](09-dev-v1-blue.png)
```
