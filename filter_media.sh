# filters given directory for image and video files

# Check for input
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <FILES_DIR>" >&2
  exit 1
fi

FILES_DIR="$1"

# Check that it's a directory
if [[ ! -d "$FILES_DIR" ]]; then
  echo "Error: '$FILES_DIR' is not a directory" >&2
  exit 1
fi

find "$FILES_DIR" -type f -print0 \
  | xargs -0 -n 1 -P "$(nproc)" -I {} file --mime-type "{}" \
  | grep -E 'image/|video/' \
  | cut -d: -f1
