#!/bin/bash
# remove-mariadb.sh

set -e

echo "Removing references to mariadb-connector-c..."

# テキストファイルのみ対象にして安全に置換
find . -type f -exec grep -Il 'mariadb-connector-c' {} \; | while read -r file; do
    echo "Cleaning $file"
    sed -i '/mariadb-connector-c/d' "$file"
done

echo "Cleanup complete."
