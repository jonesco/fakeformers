#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 3 ]]; then
  echo 'Usage: bash scripts/assemble_prompt.sh <finish> <animal|vehicle|object> "<subject and details>"' >&2
  exit 2
fi

finish="$1"
subject_type="$2"
request="$3"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(cd "$script_dir/.." && pwd)"

case "$finish" in
  [Ss][Kk][Ee][Tt][Cc][Hh]) finish_file='02 Sketch Finish.md' ;;
  [Pp][Hh][Oo][Tt][Oo][Rr][Ee][Aa][Ll]|[Rr][Ee][Aa][Ll][Ii][Ss][Tt][Ii][Cc]) finish_file='03 Photoreal Finish.md' ;;
  [Vv][Ii][Nn][Tt][Aa][Gg][Ee]|[Cc][Aa][Tt][Aa][Ll][Oo][Gg]) finish_file='04 Vintage Finish.md' ;;
  [Ss][Cc][Hh][Ee][Mm][Aa][Tt][Ii][Cc]|[Tt][Ee][Cc][Hh][Nn][Ii][Cc][Aa][Ll]|[Bb][Ll][Uu][Ee][Pp][Rr][Ii][Nn][Tt]) finish_file='05 Schematic Finish.md' ;;
  [Gg]1|[Gg]eneration[[:space:]][Oo]ne|[Gg]eneration[[:space:]]1) finish_file='13 G1 Finish.md' ;;
  *)
    echo "Unknown finish: $finish" >&2
    exit 2
    ;;
esac

case "$subject_type" in
  [Aa][Nn][Ii][Mm][Aa][Ll]|[Cc][Rr][Ee][Aa][Tt][Uu][Rr][Ee]|[Oo][Rr][Gg][Aa][Nn][Ii][Ss][Mm]) type_file='10 Animal Rules.md' ;;
  [Vv][Ee][Hh][Ii][Cc][Ll][Ee]|[Mm][Oo][Bb][Ii][Ll][Ee]) type_file='11 Vehicle Rules.md' ;;
  [Oo][Bb][Jj][Ee][Cc][Tt]|[Dd][Ee][Vv][Ii][Cc][Ee]|[Tt][Oo][Oo][Ll]|[Ss][Tt][Rr][Uu][Cc][Tt][Uu][Rr][Ee]) type_file='12 Object Rules.md' ;;
  *)
    echo "Unknown subject type: $subject_type" >&2
    exit 2
    ;;
esac

emit_file() {
  local file="$1"
  printf '\n\n'
  sed -n '1,$p' "$project_dir/$file"
}

emit_file '01 Shared Design Rules.md'
emit_file "$finish_file"
emit_file "$type_file"

printf '\n\n# Completed Subject Specification\n\n%s\n' "$request"

emit_file '08 Style Guide.md'
emit_file '09 Negative Prompt.md'
