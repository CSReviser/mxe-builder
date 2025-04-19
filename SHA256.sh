#!/usr/bin/env bash
set -e

QT_VERSION=6.5.3
QT_TAR="qt-everywhere-src-${QT_VERSION}.tar.xz"
QT_URL="https://download.qt.io/archive/qt/6.5/${QT_VERSION}/single/${QT_TAR}"
QT_SHA256_EXPECTED="6c837dde77d5c2e2f011d2be9a98a9a8ae0c2529f1fdd52e12282ce2e0e9cf4d"  # 要確認・公式照合

# 取得
if [ ! -f "$QT_TAR" ]; then
  echo "Downloading Qt ${QT_VERSION}..."
  curl -LO "$QT_URL"
fi

# 検証
echo "Verifying SHA256..."
ACTUAL=$(sha256sum "$QT_TAR" | awk '{print $1}')
if [ "$ACTUAL" != "$QT_SHA256_EXPECTED" ]; then
  echo "ERROR: SHA256 mismatch!"
  echo "Expected: $QT_SHA256_EXPECTED"
  echo "Actual  : $ACTUAL"
  exit 1
else
  echo "SHA256 verified: $ACTUAL"
fi