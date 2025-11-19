#!/usr/bin/env zsh
set -euo pipefail

# ----------------------------------------
#  mas-install.sh
#  Mac App Store アプリを一括インストール
#  - 既に入っているものはスキップ
#  - mas が無ければ Homebrew で導入
# ----------------------------------------

# mas が無ければ Homebrew からインストール
if ! command -v mas >/dev/null 2>&1; then
  echo "mas が見つかりません。Homebrew からインストールします..."

  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew がインストールされていません。先に Homebrew を導入してください。" >&2
    exit 1
  fi

  brew install mas
fi

# インストール対象（App Store の App ID : 表示名）
# 必要に応じてコメントアウトや追加をしてください
apps=(
  # "405399194:Kindle"              # Kindle →　なくなったらしい
  "539883307:LINE"                  # LINE
  "6446116532:MindNode"             # MindNode: Mind Map & Outline
  "1429033973:RunCat"               # RunCat
)

echo "=== Mac App Store アプリのインストールを開始します ==="

# 既にインストール済みかどうかは mas list の ID で判定
installed_ids=$(mas list | awk '{print $1}')

for entry in "${apps[@]}"; do
  id="${entry%%:*}"
  name="${entry#*:}"

  if echo "$installed_ids" | grep -qx "$id"; then
    echo "skip   $name ($id) ・・・ 既にインストール済み"
  else
    echo "install $name ($id)"
    mas install "$id"
  fi
done

echo "=== 完了しました ==="
