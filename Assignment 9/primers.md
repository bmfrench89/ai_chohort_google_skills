# Assignment 9 — 2-Minute Lab Primers

Skim the relevant primer **before** starting each timed lab so you know exactly what you're
building and don't burn clock figuring out the goal. Concepts map to lectures L9.1/L9.2/L9.4.

---

## Course 1 — Logging and Monitoring

### Lab 1 — Service Monitoring (SLIs · SLOs · error budgets) — L9.2

**What it is:** define reliability targets for a service and watch its error budget in Cloud
Monitoring's **Services / SLO** tooling (usually against a pre-deployed demo microservices app).

**Key concepts:**
- **SLI** (*indicator*) — a measured ratio of "good" events, e.g. availability (`good requests / total`) or latency (`% of requests < 300 ms`).
- **SLO** (*objective*) — the target for that SLI over a window, e.g. **99% of requests succeed over 28 days**. What you commit to.
- **Error budget** = `100% − SLO`. A 99.9% SLO ⇒ **0.1%** allowed failure. Burn it down → freeze risky changes. **Burn rate** = how fast you're spending it.
- **SLA** — the *contractual* version (with penalties); always looser than your SLO.

**What you'll do:** pick a service → create an SLO (choose SLI type = availability **or** latency, a goal like `99%`, and a rolling/calendar compliance window) → view the **error-budget** chart and remaining budget. You may add a **burn-rate alert**.

**Watch for / 📸:** getting the SLI *type* + goal % + window right. Screenshot the completed **SLO with its error-budget chart** and the green *Check my progress*.

### Lab 2 — Alerting in Google Cloud (policies · notification channels) — L9.2 · L9.4

**What it is:** build alerts that fire on **user impact** (symptoms), not noise (causes).

**Key concepts:**
- **Notification channel** — where an alert goes: email, SMS, Slack, PagerDuty, Pub/Sub, webhook. Create this first.
- **Alerting policy** — one or more **conditions** on a metric (threshold / metric-absence / forecast) + duration ("for 1 min") that open an **incident** when met.
- **Alert on golden signals** — latency, traffic, **errors**, saturation — not on every low-level blip.
- **Log-based alerts** — fire on a matching log entry (e.g. a specific error string).

**What you'll do:** create a notification channel (email) → create an alerting policy with a condition (metric threshold and/or log-based) → attach the channel + write clear documentation → optionally generate load to trip it and see the incident.

**Watch for / 📸:** threshold **and** duration both matter; make sure the channel is attached. Screenshot the **policy config** (and a fired **incident** if you trigger one) + green checkpoints.

### Lab 3 — Monitoring & Dashboarding Multiple Projects (metrics · dashboards · uptime) — L9.1 · L9.4

**What it is:** view metrics across **multiple projects** from one scope, build a **golden-signal
dashboard**, and add **uptime checks**.

**Key concepts:**
- **Metrics scope** — a "scoping" project that can read metrics from several monitored projects (multi-project observability).
- **Custom dashboard** — charts (line / stacked-bar / heatmap) for the golden signals; built from **Metrics Explorer** queries.
- **Uptime check** — a synthetic probe (HTTP/HTTPS/TCP) hitting an endpoint from multiple global locations; pair it with an alert so you're paged when it fails.

**What you'll do:** add a second project to the **metrics scope** → build a dashboard with golden-signal charts → create an **uptime check** against a service/endpoint + an alert on it.

**Watch for / 📸:** actually adding the 2nd project to the scope; uptime-check target (resource/host/path + frequency). Screenshot the **dashboard** and the **uptime check** + green checkpoints.

---

## Course 2 — Observability

### Lab — Using Cloud Trace to View Application Latency (distributed tracing) — L9.1 · L9.4

**What it is:** follow one request as it hops **across services** and pinpoint the **slowest
span** (the latency bottleneck) using Cloud Trace.

**Key concepts:**
- **Trace** = a tree of **spans**; each span = one unit of work with a start/end time. The trace **waterfall** shows where time actually goes.
- **Cloud Trace** collects this latency data, shows per-request waterfalls, latency **distributions**, and analysis reports.
- **Instrumentation** — the app emits spans (OpenTelemetry / Cloud Trace libs); you usually **deploy a sample app** and **generate traffic** to produce traces.

**What you'll do:** deploy/run the instrumented sample app → generate load → open **Cloud Trace → Trace explorer** → open a trace **waterfall** → identify the span with the highest latency = the bottleneck.

**Watch for / 📸:**
- ⚠️ **This is the likely home of the outdated Node.js command.** During the app deploy/run step, watch for `npm`/`node` errors — **paste me the exact command + error** and we'll fix (probably `nvm install --lts && nvm use`, or an updated package). Log it in [`lab-log.md`](lab-log.md).
- Generate **enough traffic** for traces to appear (they can take a minute).
- Screenshot the **trace waterfall with the bottleneck span highlighted** + green checkpoints.

---

*Full rubric & points: [`rubric.md`](rubric.md) · command/issue log: [`lab-log.md`](lab-log.md)*
