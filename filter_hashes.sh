# filters out any files which don't match git hashes found in hash file (note hashes are git hashes, of the form `blob <size string>\0<data>`)

# Usage instructions
if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <FILES_LIST> <HASH_FILE>" >&2
  exit 1
fi

FILES_LIST="$1"
HASH_FILE="$2"

# Check input files exist
if [[ ! -f "$FILES_LIST" ]]; then
  echo "Error: FILES_LIST '$FILES_LIST' not found." >&2
  exit 1
fi

if [[ ! -f "$HASH_FILE" ]]; then
  echo "Error: HASH_FILE '$HASH_FILE' not found." >&2
  exit 1
fi

export HASH_FILE

xargs -a "$FILES_LIST" -n 1 -P "$(nproc)" -I {} bash -c '
  file="{}"
  [ -f "$file" ] || exit 0
  hash=$(git hash-object "$file") || exit 0
  if ! grep -Fxq "$hash" "$HASH_FILE"; then
    realpath "$file"
  fi
'
