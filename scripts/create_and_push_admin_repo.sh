#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   GITHUB_USERNAME=your-user \
#   ADMIN_REPO=spark-admin \
#   ./scripts/create_and_push_admin_repo.sh
#
# Optional:
#   GITHUB_ORG=my-org   # defaults to GITHUB_USERNAME
#   USE_GH_CLI=true     # create repo via gh CLI when available

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXPORT_DIR="${ROOT_DIR}/exported-repos"
ADMIN_DIR="${EXPORT_DIR}/admin-panel"

: "${GITHUB_USERNAME:?Set GITHUB_USERNAME}"
: "${ADMIN_REPO:=spark-admin}"
: "${GITHUB_ORG:=${GITHUB_USERNAME}}"

if [[ ! -d "${ROOT_DIR}/admin-panel" ]]; then
  echo "Error: ${ROOT_DIR}/admin-panel not found."
  exit 1
fi

rm -rf "${ADMIN_DIR}"
mkdir -p "${ADMIN_DIR}"

rsync -a --delete --exclude '.git' "${ROOT_DIR}/admin-panel/" "${ADMIN_DIR}/"

pushd "${ADMIN_DIR}" >/dev/null

git init
git add .
git commit -m "chore: initial admin panel import"
git branch -M main
git remote add origin "https://github.com/${GITHUB_ORG}/${ADMIN_REPO}.git"

if [[ "${USE_GH_CLI:-false}" == "true" ]] && command -v gh >/dev/null 2>&1; then
  gh repo create "${GITHUB_ORG}/${ADMIN_REPO}" --public --source . --remote origin --push
else
  git push -u origin main
fi

popd >/dev/null

echo "Done. Created and pushed:"
echo "- https://github.com/${GITHUB_ORG}/${ADMIN_REPO}"
