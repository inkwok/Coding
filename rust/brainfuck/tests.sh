#!/bin/bash

files=()
path="bf_tests/"
target="./target/debug/brainfuck"

set -euo pipefail

if [ ! -d "$path" ]; then
    echo "Directory '$path' does not exist." >&2
    exit 1
fi
while IFS= read -r filename; do
    files+=("$filename")
done < <(find "$path" -maxdepth 1 -type f -exec basename {} \;)
if [ ${#files[@]} -eq 0 ]; then
    echo "No files found in '$path'." >&2
    exit 1
fi

cargo build
echo -e "\x1b[1;32mRunning tests...\x1b[0m"
for file in "${files[@]}"; do
    echo -e "\x1b[1;32m[test] ${file}\x1b[0m"
    $target "$path${file}"
    echo ""
done
# cargo clean
