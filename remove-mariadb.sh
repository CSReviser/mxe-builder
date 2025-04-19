#!/usr/bin/env bash
set -e

echo "Safely removing mariadb-connector-c from .mk files..."

FILES=$(find ./mxe/src -name "*.mk" -type f)

for file in $FILES; do
    if grep -q 'mariadb-connector-c' "$file"; then
        echo "Processing $file"
        cp "$file" "$file.bak"
        # DEPS行だけを対象にmariadb-connector-cを削除（改行やTABは保持）
        awk '
        /_DEPS/ {
            gsub(/mariadb-connector-c[[:space:]]*\\?/, "");
        }
        { print }
        ' "$file.bak" > "$file"
    fi
done

# 不要なファイルを削除
if [ -f ./mxe/src/mariadb-connector-c.mk ]; then
    echo "Removing mariadb-connector-c.mk"
    rm ./mxe/src/mariadb-connector-c.mk
fi

# キャッシュをクリア
echo "Clearing MXE build cache..."
rm -rf mxe/usr/* mxe/log/* mxe/pkg/* mxe/tmp/*

echo "Cleanup complete."
