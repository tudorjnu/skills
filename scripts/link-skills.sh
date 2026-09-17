#!/usr/bin/env bash
set -euo pipefail

# Links all skills in this repo into ~/.agents/skills for pi, preserving the
# repo's bucket layout: skills/<bucket>/<name> -> ~/.agents/skills/<bucket>/<name>.
# Each entry is a symlink, so a `git pull` keeps installed skills up to date.
#
# Also migrates older installs: this repo's skills found flat at
# ~/.agents/skills/<name> (symlinked by previous linkers or copied by the
# `npx skills` CLI) are removed and relinked under their bucket. Skills from
# other sources are left untouched.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DESTS=("$HOME/.agents/skills")

# Collect the repo's skills once: name, bucket, source dir.
names=()
buckets=()
srcs=()
while IFS= read -r -d '' skill_md; do
  src="$(dirname "$skill_md")"
  names+=("$(basename "$src")")
  buckets+=("$(basename "$(dirname "$src")")")
  srcs+=("$src")
done < <(find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -print0)

valid_targets="$(mktemp)"
trap 'rm -f "$valid_targets"' EXIT
for i in "${!names[@]}"; do
  printf '%s\n' "${srcs[$i]}"
done >"$valid_targets"

for DEST in "${DESTS[@]}"; do
  # If $DEST is a symlink that resolves into this repo, we'd end up writing the
  # per-skill symlinks back into the repo's own skills/ tree. Detect and bail
  # out instead of polluting the working copy.
  if [ -L "$DEST" ]; then
    resolved="$(readlink -f "$DEST")"
    case "$resolved" in
    "$REPO" | "$REPO"/*)
      echo "error: $DEST is a symlink into this repo ($resolved)." >&2
      echo "Remove it (rm \"$DEST\") and re-run; the script will recreate it as a real dir." >&2
      exit 1
      ;;
    esac
  fi

  mkdir -p "$DEST"

  # 1. Migrate: remove this repo's skills from the old flat layout.
  #    They are either old symlinks into this repo or copies made by the
  #    `npx skills` CLI; both are superseded by the bucketed links below.
  for i in "${!names[@]}"; do
    flat="$DEST/${names[$i]}"
    if [ -e "$flat" ] || [ -L "$flat" ]; then
      rm -rf "$flat"
      echo "migrated flat entry $flat"
    fi
  done

  # 2. Link every skill under its bucket dir.
  for i in "${!names[@]}"; do
    name="${names[$i]}"
    bucket="${buckets[$i]}"
    src="${srcs[$i]}"
    mkdir -p "$DEST/$bucket"
    target="$DEST/$bucket/$name"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
      rm -rf "$target"
    fi

    ln -sfn "$src" "$target"
    echo "linked $bucket/$name -> $src ($DEST)"
  done

  # 3. Prune stale bucketed links (renamed or deleted skills).
  while IFS= read -r -d '' link; do
    target="$(readlink "$link")"
    if ! grep -qxF "$target" "$valid_targets"; then
      rm "$link"
      echo "pruned stale link $link -> $target"
    fi
  done < <(find "$DEST" -mindepth 2 -maxdepth 2 -type l -print0)
done

echo ""
echo "Done. Skills are installed grouped as <bucket>/<name> under $DEST."
echo "Note: pi lists them as one user group; the bucket appears in each path."
