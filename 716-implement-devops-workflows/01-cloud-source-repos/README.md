# Lab 1 — Cloud Source Repositories

**Skill:** create and manage a private git repository hosted on Google Cloud, and push
code to it. Cloud Source Repositories (CSR) is a fully managed git host that integrates
with Cloud Build triggers (used later in Lab 3 / the challenge lab).

> Reference commands — swap `PROJECT_ID`, repo names, and regions for the values the
> live lab gives you.

## Setup

```bash
# Set your active project (the lab provides the ID)
gcloud config set project PROJECT_ID

# Enable the API
gcloud services enable sourcerepo.googleapis.com
```

## Create a repository

```bash
# Create a new Cloud Source Repository
gcloud source repos create sample-app

# Confirm it exists
gcloud source repos list
```

## Clone, commit, push

```bash
# Clone the (empty) repo locally using Google-managed credentials
gcloud source repos clone sample-app
cd sample-app

# ...add files...
git add .
git commit -m "Initial commit"

# Push to the CSR 'master' branch
git push origin master
```

If prompted for credentials outside Cloud Shell, configure the git credential helper:

```bash
git config --global credential.https://source.developers.google.com.helper gcloud.sh
```

## Verify in the console

- **Navigation menu → Source Repositories** (or `https://source.cloud.google.com`)
- You should see `sample-app` with your commit.

## Notes / what I actually did

<!-- Fill in: repo name used, any auth hiccups, screenshots, etc. -->
- Project ID:
- Repo name:
- Gotchas:
