#!/bin/bash
# remove-mariadb.sh

set -e

echo "Safely removing mariadb-connector-c from .mk files..."

find . -name '*.mk' -print0 | while IFS= read -r -d '' file; do
    if grep -q 'mariadb-connector-c' "$file"; then
        echo "Processing $file"

        # sedで連結行のmariadb-connector-cを安全に除去
        sed -i.bak -E '/\\$/ {
            :a
            N
            /\\$/ba
        } ; s/\\?[[:space:]]*mariadb-connector-c\\?[[:space:]]*\\?\\n//g' "$file"

        # 念のため空行や多重バックスラッシュの整理も
        sed -i -E '/^$/d' "$file"
    fi
done

echo "Cleanup complete."