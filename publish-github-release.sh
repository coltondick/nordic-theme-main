#!/usr/bin/env bash
set -Eeuo pipefail

# publish-github-release.sh
#
# Creates and publishes a GitHub release using gh.
#
# Requirements:
#   - git
#   - gh
#   - authenticated gh session: gh auth login
#
# Usage:
#   ./publish-github-release.sh v1.0.0
#   ./publish-github-release.sh v1.0.0 "Release title"
#   ./publish-github-release.sh v1.0.0 "Release title" ./dist/*.zip ./dist/*.tar.gz
#
# Environment variables:
#   RELEASE_NOTES_FILE   Optional path to release notes markdown
#   TARGET_BRANCH        Optional target branch, defaults to current branch
#   PRERELEASE           Set to true for prerelease
#   DRAFT                Set to true to create as draft
#   LATEST               Set to false to avoid marking as latest
#   GENERATE_NOTES       Set to true to let GitHub generate release notes

TAG="${1:-}"
TITLE="${2:-}"
shift $(( $# >= 1 ? 1 : 0 ))
shift $(( $# >= 1 ? 1 : 0 ))

ASSETS=("$@")

RELEASE_NOTES_FILE="${RELEASE_NOTES_FILE:-}"
TARGET_BRANCH="${TARGET_BRANCH:-}"
PRERELEASE="${PRERELEASE:-false}"
DRAFT="${DRAFT:-false}"
LATEST="${LATEST:-true}"
GENERATE_NOTES="${GENERATE_NOTES:-false}"

die() {
  echo "ERROR: $*" >&2
  exit 1
}

info() {
  echo "==> $*"
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

[[ -n "$TAG" ]] || die "Missing release tag. Example: ./publish-github-release.sh v1.0.0"

command_exists git || die "git is not installed"
command_exists gh || die "GitHub CLI 'gh' is not installed"

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "Not inside a git repository"

if ! gh auth status >/dev/null 2>&1; then
  die "gh is not authenticated. Run: gh auth login"
fi

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
TARGET_BRANCH="${TARGET_BRANCH:-$CURRENT_BRANCH}"
TITLE="${TITLE:-$TAG}"

info "Repository: $(gh repo view --json nameWithOwner -q '.nameWithOwner')"
info "Target branch: $TARGET_BRANCH"
info "Tag: $TAG"
info "Title: $TITLE"

if [[ -n "$(git status --porcelain)" ]]; then
  die "Working tree is not clean. Commit, stash, or discard changes before releasing."
fi

info "Fetching latest refs"
git fetch --tags origin

if ! git rev-parse --verify "$TARGET_BRANCH" >/dev/null 2>&1; then
  git fetch origin "$TARGET_BRANCH:$TARGET_BRANCH" || die "Could not fetch target branch: $TARGET_BRANCH"
fi

LOCAL_SHA="$(git rev-parse "$TARGET_BRANCH")"
REMOTE_SHA="$(git rev-parse "origin/$TARGET_BRANCH")"

if [[ "$LOCAL_SHA" != "$REMOTE_SHA" ]]; then
  die "Local $TARGET_BRANCH is not aligned with origin/$TARGET_BRANCH. Pull or push first."
fi

if git rev-parse "$TAG" >/dev/null 2>&1; then
  info "Tag already exists locally: $TAG"
else
  info "Creating annotated tag: $TAG"
  git tag -a "$TAG" -m "Release $TAG" "$TARGET_BRANCH"
fi

if git ls-remote --tags origin "refs/tags/$TAG" | grep -q "$TAG"; then
  info "Tag already exists on origin: $TAG"
else
  info "Pushing tag to origin"
  git push origin "$TAG"
fi

if gh release view "$TAG" >/dev/null 2>&1; then
  die "Release already exists for tag: $TAG"
fi

RELEASE_ARGS=(
  "$TAG"
  --title "$TITLE"
  --target "$TARGET_BRANCH"
)

if [[ "$DRAFT" == "true" ]]; then
  RELEASE_ARGS+=(--draft)
fi

if [[ "$PRERELEASE" == "true" ]]; then
  RELEASE_ARGS+=(--prerelease)
fi

if [[ "$LATEST" == "false" ]]; then
  RELEASE_ARGS+=(--latest=false)
fi

if [[ "$GENERATE_NOTES" == "true" ]]; then
  RELEASE_ARGS+=(--generate-notes)
elif [[ -n "$RELEASE_NOTES_FILE" ]]; then
  [[ -f "$RELEASE_NOTES_FILE" ]] || die "Release notes file does not exist: $RELEASE_NOTES_FILE"
  RELEASE_ARGS+=(--notes-file "$RELEASE_NOTES_FILE")
else
  RELEASE_ARGS+=(--notes "Release $TAG")
fi

for asset in "${ASSETS[@]}"; do
  matches=( $asset )
  if [[ ${#matches[@]} -eq 0 ]]; then
    die "Asset path did not match any files: $asset"
  fi

  for match in "${matches[@]}"; do
    [[ -f "$match" ]] || die "Asset is not a file: $match"
    RELEASE_ARGS+=("$match")
  done
done

info "Creating GitHub release"
gh release create "${RELEASE_ARGS[@]}"

info "Release published successfully"
gh release view "$TAG" --web