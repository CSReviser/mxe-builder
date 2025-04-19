#!/bin/bash

# MXE のルートディレクトリ（このスクリプトを mxe フォルダ直下に置いて実行する想定）
cd "$(dirname "$0")"

echo "=== 検索: バージョン '6.9.0' を含む行 ==="
grep -rn --include="*.mk" "6.9.0" .

echo
echo "=== 検索: URLなどに '6.9' を含む行 ==="
grep -rn --include="*.mk" "6.9" .