#!/usr/bin/env bash
# Riallinea il marketplace enricopezzini in locale.
#   1. git pull nel repo del marketplace
#   2. riallinea il manifest nel plugin manager di Claude
#   3. reinstalla il plugin `core` all'ultima versione (versioning via SHA git)
#
# Uso: ./scripts/update-local.sh
set -euo pipefail

MARKETPLACE="${1:-enricopezzini}"
PLUGIN="${2:-core}"

# Root del repo = cartella padre di /scripts
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "==> Repo marketplace: $REPO_ROOT"

cd "$REPO_ROOT"

echo "==> git pull..."
git pull --ff-only

echo "==> claude plugin marketplace update $MARKETPLACE..."
claude plugin marketplace update "$MARKETPLACE"

echo "==> claude plugin install $PLUGIN@$MARKETPLACE..."
claude plugin install "$PLUGIN@$MARKETPLACE"

echo "==> Fatto. Skill riallineate all'ultima versione."
