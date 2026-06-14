#!/usr/bin/env bash
# Install the agent-repo-card skills into a Claude Code skills directory.
#   ./install.sh          -> into ./.claude/skills (current repo)
#   ./install.sh --user   -> into ~/.claude/skills (global)
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills"

if [[ "${1:-}" == "--user" ]]; then
  DEST="$HOME/.claude/skills"
else
  DEST="$(pwd)/.claude/skills"
fi

mkdir -p "$DEST"

for skill in "$SRC"/*/; do
  name="$(basename "$skill")"
  rm -rf "$DEST/$name"
  cp -R "$skill" "$DEST/$name"
  echo "installed: $name -> $DEST/$name"
done

echo "Done. Open Claude Code here and try: /ux-audit"
