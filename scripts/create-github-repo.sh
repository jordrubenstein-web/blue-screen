#!/usr/bin/env bash
set -euo pipefail
REPO_NAME="${1:-blue-screen}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if ! command -v gh >/dev/null 2>&1; then
  echo "Install GitHub CLI: https://cli.github.com" >&2
  exit 1
fi

if ! gh auth status &>/dev/null; then
  echo "Not logged in. Run: gh auth login" >&2
  exit 1
fi

if git remote get-url origin &>/dev/null 2>&1; then
  echo "Remote 'origin' exists. Pushing to origin..."
  git push -u origin main
else
  gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
fi
