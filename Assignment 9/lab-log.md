# Assignment 9 — Lab Log (commands & issues)

Running log of the **exact CLI commands** run in each lab and any **issues + fixes** hit
along the way. Updated live as we work through the labs.

> Much of Module 9 is Cloud Console UI (dashboards, alerting policies, SLOs, trace views), so
> some labs have few CLI commands — those sections capture the key console steps plus any
> Cloud Shell commands the lab uses.

## ⚠️ Known issues / watch list (before we start)

- **Outdated Node.js command (heads-up from classmates):** one of the labs reportedly has a
  step with an **outdated Node.js / npm command** that errors. Watch for `npm` / `node` /
  `nodejs` failures — e.g. `EBADENGINE` / "unsupported engine", `npm ERR!`, a deprecated flag,
  or a too-old Node version. **When it hits: paste me the exact command + full error** (don't
  retype blindly). We'll pin the confirmed fix right here — likely a Node version bump
  (`nvm install --lts` / `nvm use`) or an updated package/command.
  - Most likely the **Cloud Trace** lab (deploys a Node.js sample app) — _confirm when we reach it._

---

## Course 1 — Logging and Monitoring (template 99)

### Lab 1 — Service Monitoring  ·  status: 🔄 in progress
> Reached via the 864 course URL, but it's the **Service Monitoring** lab = Course 1 Lab 1 (25 pts). 30-min timer. Deploy a Node.js app to App Engine → create a 99.5% availability SLO → tie a burn-rate alert → trigger it.

- **Task 1 — deploy test app (App Engine · Node.js):**
  ```bash
  git clone https://github.com/haggman/HelloLoggingNodeJS.git
  cd HelloLoggingNodeJS
  cat app.yaml                                        # repo ships runtime: nodejs22
  sed -i 's/^runtime:.*/runtime: nodejs22/' app.yaml  # keep nodejs22 (see issue below)
  cat app.yaml                                        # confirm runtime: nodejs22
  gcloud app create --region=us-central
  gcloud app deploy                                   # type y
  echo https://$DEVSHELL_PROJECT_ID.appspot.com       # open → "Hello World!"
  ```
- **Task 2 — SLO + alert (Cloud Console + Cloud Shell):**
  ```bash
  # load generator (run in a 2nd Cloud Shell tab, leave running):
  while true; do curl -s https://$DEVSHELL_PROJECT_ID.appspot.com/random-error -w '\n'; sleep .1s; done
  ```
  Console: Monitoring → SLOs → default App Engine service → **+Create SLO** (Availability · Request-based · Rolling 7 days · goal **99.5%**) → create SLO alert (lookback **10 min**, burn rate **1.5**, email notification channel). Trigger: edit `index.js` `/random-error` route (~line 126) `Math.random` **1000 → 20**, then `gcloud app deploy` again.

- **Issues & fixes:**
  - ⚠️✅ **Node.js runtime — the classmate-flagged issue, and it's the LAB TEXT that's outdated.** The lab tells you to set `runtime: nodejs20`, but the `HelloLoggingNodeJS` repo already ships **`runtime: nodejs22`** (maintainer bumped it because App Engine decommissions old runtimes). Following the lab's `nodejs20` can fail as it ages out. **Fix: leave/set `runtime: nodejs22`** (the current supported runtime); the Check-my-progress grader only cares that the app deploys + serves, not the version. Observed here: `cat app.yaml` → `nodejs22` out of the box.
- 📸 **Screenshots:** ☐ "Hello World!" page + green *Deploy* check · ☐ SLO with error-budget chart + green *Create an SLO* check  → `99-logging-monitoring/screenshots/01-service-monitoring.png`

### Lab 2 — Alerting in Google Cloud  ·  status: ☐
- **Key steps / console actions:**
  -
- **Commands run:**
  ```bash
  ```
- **Issues & fixes:** _none yet_
- 📸 **Screenshot captured:** ☐  → `99-logging-monitoring/screenshots/02-alerting.png`

### Lab 3 — Monitoring & Dashboarding Multiple Projects  ·  status: ☐
- **Key steps / console actions:**
  -
- **Commands run:**
  ```bash
  ```
- **Issues & fixes:** _none yet_
- 📸 **Screenshot captured:** ☐  → `99-logging-monitoring/screenshots/03-monitoring-dashboarding.png`

---

## Course 2 — Observability (template 864)

### Lab — Using Cloud Trace to View Application Latency  ·  status: ☐
- **Key steps / console actions:**
  -
- **Commands run:**
  ```bash
  ```
- **Issues & fixes:** _none yet_
- 📸 **Screenshot captured:** ☐  → `864-observability/screenshots/01-cloud-trace.png`
