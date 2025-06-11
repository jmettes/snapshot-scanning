# filters given file paths for image and video files

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 PATHS_FILE"
  echo "  PATHS_FILE: File containing newline-separated list of paths to check"
  exit 1
fi

PATHS_FILE="$1"

if [[ ! -f "$PATHS_FILE" ]]; then
  echo "Error: File '$PATHS_FILE' does not exist."
  exit 1
fi

xargs -a "$PATHS_FILE" -d '\n' file --mime-type | grep -E 'image/|video/' | cut -d: -f1
