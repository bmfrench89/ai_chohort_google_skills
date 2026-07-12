# Course 1 Notes — Logging and Monitoring in Google Cloud

A durable personal reference for [`course_templates/99`](https://www.cloudskillsboost.google/course_templates/99),
so the material is usable **outside** Google Cloud Skills Boost.

## Provenance (read me)

The deep lesson content (module text, videos, diagrams) is behind the Skills Boost login and
**can't be scraped**. So these notes are built two ways:
- **Reference notes** — authoritative summaries of each module's topic, matching the course's
  scope and objectives. Solid to study from, but not verbatim course text.
- **Your pasted content** — as you go through the course, paste lesson text / screenshot
  diagrams and they get folded into the matching section file, verbatim where useful.

## Diagram convention (mermaid)

Every diagram/image is authored as a **mermaid** block embedded in the relevant section file
(GitHub renders these inline). When you paste a screenshot of a course diagram, a **matching
mermaid version** is added next to the notes so it's reusable and editable later.

## Sections

| File | Module | Mermaid | Status |
|------|--------|:------:|--------|
| [`00-operations-suite-overview.md`](00-operations-suite-overview.md) | Intro to the Google Cloud Operations suite | telemetry flow | ✅ seeded |
| [`01-monitoring.md`](01-monitoring.md) | Monitoring — metrics, Metrics Explorer, dashboards, uptime checks | metrics scope | ✅ seeded |
| [`02-alerting.md`](02-alerting.md) | Alerting — policies, conditions, notification channels | policy flow | ✅ seeded |
| [`03-logging.md`](03-logging.md) | Cloud Logging — Logs Explorer, log-based metrics, sinks/exports | log router | ✅ seeded |
| [`04-service-monitoring-slos.md`](04-service-monitoring-slos.md) | Service Monitoring — SLIs, SLOs, error budgets | SLI→SLO→budget | ✅ seeded |

Each file carries a **mermaid** concept diagram (renders on GitHub). Paste real course
content/screenshots to make any section verbatim and to add the course's exact diagrams.

> Section list is the **standard course structure** — confirm/adjust against your actual
> module list once you're in the course, and I'll rename/split to match.
