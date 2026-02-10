#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   GITHUB_USERNAME=your-user \
#   MOBILE_REPO=spark-mobile-app \
#   ADMIN_REPO=spark-admin-panel \
#   ./scripts/create_and_push_spark_repos.sh
#
# Optional:
#   GITHUB_ORG=my-org     # defaults to GITHUB_USERNAME
#   USE_GH_CLI=true       # create repos via gh cli when available

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXPORT_DIR="${ROOT_DIR}/exported-repos"
MOBILE_DIR="${EXPORT_DIR}/mobile-app"
ADMIN_DIR="${EXPORT_DIR}/admin-panel"

: "${GITHUB_USERNAME:?Set GITHUB_USERNAME}"
: "${MOBILE_REPO:=spark-mobile-app}"
: "${ADMIN_REPO:=spark-admin-panel}"
: "${GITHUB_ORG:=${GITHUB_USERNAME}}"

rm -rf "${EXPORT_DIR}"
mkdir -p "${MOBILE_DIR}" "${ADMIN_DIR}"

# Copy Flutter app into mobile-app repo folder.
rsync -a --delete \
  --exclude '.git' \
  --exclude 'admin-panel' \
  --exclude 'exported-repos' \
  --exclude 'scripts' \
  "${ROOT_DIR}/" "${MOBILE_DIR}/"

# Copy admin panel folder into separate repo folder.
rsync -a --delete --exclude '.git' "${ROOT_DIR}/admin-panel/" "${ADMIN_DIR}/"

init_and_push_repo() {
  local repo_dir="$1"
  local repo_name="$2"

  pushd "${repo_dir}" >/dev/null
  git init
  git add .
  git commit -m "chore: initial import from monorepo"
  git branch -M main
  git remote add origin "https://github.com/${GITHUB_ORG}/${repo_name}.git"

  if [[ "${USE_GH_CLI:-false}" == "true" ]] && command -v gh >/dev/null 2>&1; then
    gh repo create "${GITHUB_ORG}/${repo_name}" --public --source . --remote origin --push
  else
    git push -u origin main
  fi
  popd >/dev/null
}

init_and_push_repo "${MOBILE_DIR}" "${MOBILE_REPO}"
init_and_push_repo "${ADMIN_DIR}" "${ADMIN_REPO}"

echo "Done. Created and pushed:"
echo "- https://github.com/${GITHUB_ORG}/${MOBILE_REPO}"
echo "- https://github.com/${GITHUB_ORG}/${ADMIN_REPO}"
