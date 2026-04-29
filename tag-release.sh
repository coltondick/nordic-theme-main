#!/usr/bin/env bash
set -Eeuo pipefail

# tag-release.sh
#
# Creates and pushes an annotated release tag.
# GitHub Actions will handle validation and publishing the release.
#
# Usage:
#   ./tag-release.sh v2.3.7
#   ./tag-release.sh v2.3.7 main
#   ./tag-release.sh v2.3.7 master

TAG="${1:-}"
BRANCH="${2:-main}"

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

[[ -n "$TAG" ]] || die "Missing release tag. Usage: ./tag-release.sh v2.3.7 [branch]"

command_exists git || die "git is not installed"

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "Not inside a git repository"

if [[ -n "$(git status --porcelain)" ]]; then
  die "Working tree is not clean. Commit, stash, or discard changes before releasing."
fi

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

info "Current branch: $CURRENT_BRANCH"
info "Target branch: $BRANCH"
info "Release tag: $TAG"

info "Fetching latest refs and tags"
git fetch origin --tags

if ! git rev-parse --verify "$BRANCH" >/dev/null 2>&1; then
  info "Local branch $BRANCH does not exist. Fetching from origin."
  git fetch origin "$BRANCH:$BRANCH" || die "Could not fetch branch: $BRANCH"
fi

if [[ "$CURRENT_BRANCH" != "$BRANCH" ]]; then
  info "Checking out $BRANCH"
  git checkout "$BRANCH"
fi

info "Pulling latest changes"
git pull --ff-only origin "$BRANCH"

LOCAL_SHA="$(git rev-parse "$BRANCH")"
REMOTE_SHA="$(git rev-parse "origin/$BRANCH")"

if [[ "$LOCAL_SHA" != "$REMOTE_SHA" ]]; then
  die "Local $BRANCH is not aligned with origin/$BRANCH."
fi

if git rev-parse "$TAG" >/dev/null 2>&1; then
  die "Tag already exists locally: $TAG"
fi

if git ls-remote --tags origin "refs/tags/$TAG" | grep -q "refs/tags/$TAG"; then
  die "Tag already exists on origin: $TAG"
fi

info "Creating annotated tag: $TAG"
git tag -a "$TAG" -m "Release $TAG"

info "Pushing tag to origin"
git push origin "$TAG"

info "Release tag pushed successfully"
info "GitHub Actions will now validate and publish the release."