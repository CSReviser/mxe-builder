#!/usr/bin/env bash
set -e

echo "Safely removing mariadb-connector-c from .mk files..."

FILES=$(find ./mxe/src -name "*.mk" -type f)

for file in $FILES; do
    if grep -q 'mariadb-connector-c' "$file"; then
        echo "Processing $file"
        cp "$file" "$file.bak"
        sed -i.bak '/mariadb-connector-c/d' "$file"
    fi
done

# 不要ならファイル自体も削除
if [ -f ./mxe/src/mariadb-connector-c.mk ]; then
    echo "Removing mariadb-connector-c.mk"
    rm ./mxe/src/mariadb-connector-c.mk
fi

echo "Cleanup complete."