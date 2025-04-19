#!/usr/bin/env bash
set -e

echo "Safely removing mariadb-connector-c from .mk files..."

# 処理対象の .mk ファイル一覧
FILES=$(grep -rl 'mariadb-connector-c' mxe/src/)

for file in $FILES; do
    echo "Processing $file"
    
    # mariadb-connector-c を安全に削除し、行末の \ があれば次の行のつなぎも考慮
    sed -i.bak -E '/mariadb-connector-c/{
        s/mariadb-connector-c[[:space:]]*\\[[:space:]]*//g;
        s/mariadb-connector-c//g;
    }' "$file"

    # インデント修正：行頭のスペース8個を TAB に変換（Makefile構文用）
    sed -i -E 's/^ {8}/\t/' "$file"
done

echo "Cleanup complete."