# filters out any files which don't match git hashes found in hash file

set -euo pipefail

usage() {
  echo "Usage: $0 HASH_FILE [DIRECTORY]"
  echo
  echo "Find files in DIRECTORY (default: current dir) not listed by hash in HASH_FILE."
  echo
  echo "Arguments:"
  echo "  HASH_FILE   File with one git hash per line (REQUIRED)"
  echo "  DIRECTORY   Directory to scan (optional, defaults to .)"
  exit 1
}

# Accept 1 or 2 arguments
if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Error: Invalid number of arguments."
  usage
fi

HASH_FILE="$1"
DIR="${2:-.}"

if [[ ! -f "$HASH_FILE" ]]; then
  echo "Error: HASH_FILE '$HASH_FILE' does not exist."
  exit 1
fi

if [[ ! -d "$DIR" ]]; then
  echo "Error: DIRECTORY '$DIR' does not exist."
  exit 1
fi

find "$DIR" -type f -print0 | while IFS= read -r -d '' file; do
  hash=$(git hash-object "$file")
  if ! grep -Fxq "$hash" "$HASH_FILE"; then 
    echo "$(realpath "$file")"
  fi
done
