# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Git & Commit Rules

- Never include references to Claude or any AI assistant in commit messages, PR descriptions, or code comments.
- Branch from `main` for feature development; use the `future` branch for version-bump work (see Releasing below).
- PRs to `main` trigger automated lint and build checks.

### Standard PR Workflow

1. Create a dedicated branch from `main` (e.g., `docs/update-readme`, `fix/token-validation`).
2. Stage and commit changes with a clear, descriptive message.
3. Push the branch to `origin` with `-u` to set upstream tracking.
4. Open a PR targeting `main` using `gh pr create`.
5. Squash-merge the PR using `gh pr merge <number> --squash`.
6. Delete the remote branch: `git push origin --delete <branch>`.
7. Switch to `main`, pull, and force-delete the local branch: `git branch -D <branch>`.
8. Sync the `future` branch with `main`: `git checkout future && git merge main --no-edit && git push origin future && git checkout main`.

### Branch Strategy

This repository uses two persistent branches:

| Branch | Purpose |
|--------|---------|
| `main` | Production branch. All PRs target this branch. Protected (requires PR + CI). |
| `future` | Staging branch for version-bump work (releases only). Unprotected. |

**Key rules:**
- Feature branches (docs, fixes, etc.) → branch from `main`, merge to `main`
- Release work → done directly on `future`, then PR to `main`
- **After ANY merge to `main`**, sync `future` to keep them aligned

**Handling conflicts when syncing `future`:**

If `future` has uncommitted release work when you need to sync:
```bash
git checkout future
git merge main           # Resolve conflicts if any
git push origin future
```

If starting a new release and `future` is behind `main`:
```bash
git checkout future
git merge main --no-edit  # Bring in latest changes first
git push origin future
# Now start the release work
```

## CI — Lint & Build

There is no local lint or build command. Both run exclusively in GitHub Actions:

- **Lint** (`.github/workflows/lint.yaml`): runs `frenck/action-addon-linter` on each addon directory found by `home-assistant/actions/helpers/find-addons`, then runs `shellcheck` on every file under `rootfs/etc/services.d/`.
- **Build** (`.github/workflows/builder.yaml`): triggered only when one of the *monitored files* (`build.yaml`, `config.yaml`, `Dockerfile`, or anything under `rootfs/`) changes. Builds both supported architectures (`aarch64`, `amd64`) using `home-assistant/builder`. On `main` push the image is published to `ghcr.io/fredericks1982/{arch}-addon-cloudflared`; on PRs the build uses `--test` only (no publish).

**Branch Protection:** The `main` branch requires PRs with passing CI checks (Lint, Build) before merging. Admins can bypass in emergencies. Tags and releases are unaffected.

## Local Development (Devcontainer)

The repo ships a devcontainer (`.devcontainer.json`) based on `ghcr.io/home-assistant/devcontainer:addons`. Open the repo in that container to get a full Home Assistant Supervisor environment with the addon auto-discovered as a local addon.

VSCode tasks in `.vscode/tasks.json` provide three one-click actions for the `cloudflared` addon:

| Task | What it does |
|---|---|
| **Start Home Assistant** | Runs `supervisor_run` (do this first) |
| **Start Addon** | Stops then starts `local_cloudflared`; tails its Docker logs |
| **Rebuild and Start Addon** | Rebuilds the image, starts, and tails logs |

**Important:** While developing locally, comment out the `image:` key in `cloudflared/config.yaml` so Supervisor builds from the local Dockerfile instead of pulling the published image. Remember to restore it before merging to `main`.

## Architecture Overview

This is a single-addon repository. Everything addon-related lives under `cloudflared/`.

```
cloudflared/
├── Dockerfile          # Pulls tempio + cloudflared binary; copies rootfs
├── build.yaml          # Base images per arch; tempio version; OCI labels
├── config.yaml         # HA addon manifest: version, schema, options, image
├── rootfs/
│   └── etc/
│       ├── cloudflared/
│       │   └── cloudflared.yaml   # Static cloudflared origin config (connectTimeout)
│       └── services.d/
│           └── cloudflared/
│               ├── run            # s6-overlay: starts the tunnel daemon
│               └── finish         # s6-overlay: halts supervision on non-zero exit
├── translations/en.yaml           # UI labels for the config option
├── DOCS.md             # User-facing addon documentation (rendered in HA UI)
└── CHANGELOG.md        # CalVer release notes
```

**Process supervision:** The container runs under [s6-overlay](https://github.com/just-containers/s6-overlay). The `run` script is the entry point; it reads the token via `bashio::config`, then `exec`s `cloudflared tunnel run`. If the process exits with a non-zero code the `finish` script halts the container (Supervisor's watchdog will restart it).

**Templating:** [tempio](https://github.com/home-assistant/tempio) is installed in the image (version pinned in `build.yaml`) but is not currently used by this addon. It is available if config-file templating is needed in the future.

**Arch mapping in the Dockerfile:** Home Assistant build arches do not match Cloudflare's release naming. The Dockerfile maps them:

| HA arch | Cloudflare binary suffix |
|---|---|
| amd64 | amd64 |
| aarch64 | arm64 |

## Releasing / Updating Cloudflared

1. Check https://github.com/cloudflare/cloudflared/releases/ to retrieve the latest cloudflared version.
2. Prompt the user for confirmation on which version to upgrade to.
3. Switch to the `future` branch.
4. Update the cloudflared download URL version in `cloudflared/Dockerfile` (the `curl` line).
5. Update `version` in `cloudflared/config.yaml` to match. Use CalVer: `YYYY.MM.MICRO` (e.g. `2025.6.0`).
6. Add a changelog entry in `cloudflared/CHANGELOG.md`.
7. Commit, push, and verify CI passes.
8. Create a PR from `future` → `main` using `gh pr create --base main --head future`. Wait for CI to pass, then merge with `gh pr merge --squash`. This triggers the real build and publishes the image. **Do not delete the `future` branch** — it is a persistent branch used for all version-bump work.
9. Create a git tag matching the version, push it, and open a GitHub release at `https://github.com/fredericks1982/hass-addon-cloudflared/releases`. Include a link to the changelog in the release notes:
   ```
   ## Full Changelog
   See [CHANGELOG.md](cloudflared/CHANGELOG.md) for complete details.
   ```
10. Sync `future` with `main` to keep them aligned: `git checkout future && git merge main --no-edit && git push origin future`. This ensures both branches have identical content for the next release cycle.
