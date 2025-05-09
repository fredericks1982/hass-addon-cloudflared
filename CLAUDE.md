# Cloudflared Add-on Development Guide

## Build & Test Commands
- Lint: `frenck/action-addon-linter` (via Github Actions)
- Build: `home-assistant/builder` with args: `--test --[arch] --target /data/cloudflared --addon`
- Local build testing: Use Home Assistant development environment
- Update procedure: See HOW_TO_UPDATE.txt

## Code Style Guidelines
- Follow Home Assistant add-on conventions
- Docker best practices for multi-stage builds
- Shell scripts should use bashio for HA integration
- Use descriptive variable names prefixed with their type
- Always quote shell variables and command substitutions
- Follow CalVer versioning: YYYY.MM.MICRO
- Keep logs informative but concise
- Proper error handling in shell scripts
- Document all configuration options thoroughly

## Git Workflow
- Commit messages should be clear and descriptive
- Never include references to Claude or any AI assistant in the comments for commits, PRs, or code
- Create tags for releases and GitHub releases
- Branch from main for feature development
- PR workflow uses automated lint and build testing