#!/usr/bin/env bash
set -e

echo "Safely removing mariadb-connector-c from .mk files..."

FILES=$(grep -rl 'mariadb-connector-c' mxe/src/)

for file in $FILES; do
    echo "Processing $file"
    
    # mariadb-connector-c を安全に削除
    sed -i.bak -E '/mariadb-connector-c/{
        s/mariadb-connector-c[[:space:]]*\\[[:space:]]*//g;
        s/mariadb-connector-c//g;
    }' "$file"

    # インデント修正は $(PKG)_DEPS 行だけに限定
    sed -i -E '/^\s*\$\(PKG\)_DEPS/ s/^ {8}/\t/' "$file"
done

echo "Cleanup complete."