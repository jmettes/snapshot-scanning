# Reads through list of snapshot ID:
# - downloads snapshot image using coldsnap
# - mounts image
# - filters media files
# - filters files against existing notebook file hashes

if [ $# -ne 2 ]; then
  echo "Usage: $0 SNAPSHOT_LIST_FILE HASH_FILE"
  exit 1
fi

SNAPSHOT_LIST_FILE="$1"
HASH_FILE="$2"

if [ ! -f "$SNAPSHOT_LIST_FILE" ]; then
  echo "Missing snapshot list file: $SNAPSHOT_LIST_FILE"
  exit 1
fi

if [ ! -f "$HASH_FILE" ]; then
  echo "Missing hash file: $HASH_FILE"
  exit 1
fi

while read -r SNAPSHOT_ID; do
  [ -z "$SNAPSHOT_ID" ] && continue

  SNAPSHOT_FILE="${SNAPSHOT_ID}.img"
  SNAPSHOT_DIR="${SNAPSHOT_ID}-mount"
  SNAPSHOT_MEDIA_FILE="${SNAPSHOT_ID}-media.txt"
  SNAPSHOT_FILTERED_FILE="${SNAPSHOT_ID}-files.txt"

  echo "Processing snapshot: $SNAPSHOT_ID"

  # Clean up function
  cleanup() {
    echo "Cleaning up..."
    sudo umount "$SNAPSHOT_DIR"
    rm -rf "$SNAPSHOT_DIR" "$SNAPSHOT_FILE"
  }
  trap cleanup EXIT

  # Download snapshot
  coldsnap download "$SNAPSHOT_ID" "$SNAPSHOT_FILE"

  # Mount snapshot
  mkdir -p "$SNAPSHOT_DIR"
  sudo mount -o loop "$SNAPSHOT_FILE" "$SNAPSHOT_DIR"

  # Filter files
  # turns out it's faster to find all media files first, then to filter out dea notebook hashed files on a reduced set of files (because calculating hashes is more expensive)
  ./filter_media.sh "$SNAPSHOT_DIR" > "$SNAPSHOT_MEDIA_FILE"
  ./filter_hashes.sh "$SNAPSHOT_MEDIA_FILE" "$HASH_FILE" > "$SNAPSHOT_FILTERED_FILE"

  # Success; remove trap so cleanup doesn't re-run
  trap - EXIT
  cleanup

done < "$SNAPSHOT_LIST_FILE"
