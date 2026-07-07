# GSP330 — Completion Record

**Badge:** Implement DevOps Workflows in Google Cloud
**Completed:** 2026-07-06 · **Result:** ✅ all 6 tasks passed → skill badge earned
**Badge URL:** https://www.skills.google/public_profiles/6a99762d-bfb2-4e65-b273-58cbdefb9784/badges/25359987

The completed lab artifacts are in [`sample-app/`](sample-app/) (final v2.0 committed state).

## Environment (temporary lab — no longer live)

| Item | Value |
|------|-------|
| Project ID | `qwiklabs-gcp-01-a144cb76b171` |
| Region / Zone | `us-east1` / `us-east1-b` |
| Artifact Registry | `my-repository` (Docker) |
| GKE cluster | `hello-cluster` — Standard, Regular channel, **GKE 1.35.5**, autoscale 3 nodes / min 2 / max 6 |
| Namespaces | `prod`, `dev` |
| GitHub repo | `bmfrench89/sample-app` (branches `master`, `dev`) |
| Trigger service account | `qwiklabs-gcp-01-a144cb76b171@qwiklabs-gcp-01-a144cb76b171.iam.gserviceaccount.com` (Owner — required by org policy) |

## Pipeline

- **Triggers:** `sample-app-prod-deploy` (`^master$` → `cloudbuild.yaml` → `prod` ns) and `sample-app-dev-deploy` (`^dev$` → `cloudbuild-dev.yaml` → `dev` ns), both via the Cloud Build GitHub App.
- **Images:** `hello-cloudbuild` (prod) and `hello-cloudbuild-dev` (dev) in Artifact Registry.
- **Services:** `prod-deployment-service` (`104.196.190.49:8080`), `dev-deployment-service` (`104.196.161.203:8080`) — both LoadBalancer, port 8080.
- **App endpoints:** `/blue` (v1.0+), `/red` (added in v2.0).

## What was done, task by task

1. **Lab resources** — enabled `container` + `cloudbuild` APIs, granted Cloud Build SA `roles/container.developer`, authed GitHub via `gh`, created Artifact Registry repo + GKE cluster + `prod`/`dev` namespaces.
2. **GitHub repo** — created `sample-app`, loaded sample code from `gs://spls/gsp330/sample-app`, patched region/zone into the cloudbuild files, pushed `master` + `dev`.
3. **Triggers** — created both Cloud Build triggers (Cloud Build GitHub App, user-managed SA).
4. **v1.0 deploys** — set `<version>`→`v1.0` and the `<todo>` image names, pushed dev then master, exposed both services, verified `/blue` (blue square) in both.
5. **v2.0 deploys** — added `/red` route + `redHandler` to `main.go`, bumped to `v2.0`, pushed dev then master, verified `/red` (red square) in both.
6. **Rollback** — rolled `production-deployment` back to v1.0 by retrying build `d633aab0` (commit `df4ea75`); confirmed `/red` on prod returns **404** while `/blue` still works.

## Build IDs

| Build | Commit | What |
|-------|--------|------|
| `4aedc7ee` | `034d4b8` | dev v1.0 |
| `d633aab0` | `df4ea75` | prod v1.0 (rollback target) |
| `1649fe9c` | `e96ce8f` | dev v2.0 |
| `4d84ec25` | `aee8b2e` | prod v2.0 |
| retry of `d633aab0` | `df4ea75` | Task 6 rollback → prod v1.0 |

## Notes

- The Task 6 rollback was a **deployment action** (re-running the old v1.0 build), not a code change — so the committed source in `sample-app/` stays at v2.0. Prod was *serving* v1.0 at lab end.
- GKE version was **not pinned** in the create command; the Regular channel default (1.35.5) satisfies the lab's "1.29 or newer" requirement (pinning 1.29 would have failed as unavailable).
- Both `cloudbuild` files ship with `options: logging: CLOUD_LOGGING_ONLY`, which is what lets the user-managed service account run the build under the project's org policy.
