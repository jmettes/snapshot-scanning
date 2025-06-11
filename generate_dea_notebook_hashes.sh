# gets all Git file hashes from dea-notebooks repo across all commits
# note, hashes are of the form: (`sha1("blob <file size>\0<file content>")`)

set -euo pipefail

# Save the current directory
ORIGINAL_DIR="$(pwd)"

# Make a temp directory and ensure it's cleaned up on exit
TEMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

git clone https://github.com/GeoscienceAustralia/dea-notebooks.git "$TEMP_DIR/dea-notebooks"
cd "$TEMP_DIR/dea-notebooks"
git rev-list --all | while read commit; do git ls-tree -r "$commit" | awk '{print $3}'; done | sort -u > dea_notebook_file_hashes.txt

cp dea_notebook_file_hashes.txt "$ORIGINAL_DIR"
