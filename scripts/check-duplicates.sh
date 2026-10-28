#!/usr/bin/env bash
# Fallisce se due SKILL.md nel marketplace dichiarano lo stesso `name:`
# (le installazioni a cartella piatta, es. .agents/skills/<nome>, si sovrascriverebbero).
set -euo pipefail
cd "$(dirname "$0")/.."

dups=$(find plugins -name SKILL.md -not -path '*/node_modules/*' -print0 \
  | xargs -0 awk 'FNR==1{n=0} /^---[ \t]*$/{n++; next} n==1 && /^name:/{sub(/^name:[ \t]*/,""); gsub(/["\r]/,""); print $0 "\t" FILENAME; nextfile}' \
  | sort | awk -F'\t' '{c[$1]++; f[$1]=f[$1] "\n    " $2} END{for(k in c) if(c[k]>1) printf "  %s:%s\n", k, f[k]}')

if [ -n "$dups" ]; then
  echo "Nomi di skill duplicati:" >&2
  echo "$dups" >&2
  exit 1
fi
echo "OK: nessun nome di skill duplicato."
