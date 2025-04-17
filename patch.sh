#!/bin/bash
set -e

OLD_PATH="/home/runner/work/mxe-builder/mxe-builder/mxe"
NEW_PATH="/opt/mxe"  # または展開先に応じて変更

find mxe/ -type f \( -name "*.cmake" -o -name "*.pri" -o -name "*.la" -o -name "*.pc" \) | while read file; do
  grep -q "$OLD_PATH" "$file" && \
    sed -i "s|$OLD_PATH|$NEW_PATH|g" "$file" && \
    echo "Replaced in: $file"
done