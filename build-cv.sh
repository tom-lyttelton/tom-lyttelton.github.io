#!/usr/bin/env bash
# Rebuild assets/CV.pdf from the Overleaf LaTeX source.
# The .tex file is the single source of truth; this script just recompiles it
# and drops the PDF into the site. Run it after any CV edit, then commit.

set -euo pipefail

TEX="/Users/thomaslyttelton/Library/CloudStorage/Dropbox-Personal/Apps/Overleaf/job market/CV.tex"
SITE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TECTONIC="${TECTONIC:-$HOME/.local/bin/tectonic}"

if [[ ! -f "$TEX" ]]; then
  echo "error: CV source not found at:" >&2
  echo "  $TEX" >&2
  exit 1
fi

if [[ ! -x "$TECTONIC" ]]; then
  echo "error: tectonic not found at $TECTONIC" >&2
  exit 1
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

"$TECTONIC" -o "$TMP" "$TEX"
cp "$TMP/CV.pdf" "$SITE/assets/CV.pdf"

echo "updated: $SITE/assets/CV.pdf"
