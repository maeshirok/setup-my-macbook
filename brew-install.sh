#!/bin/zsh

# 追加の tap（必要なものだけ）
brew tap homebrew/cask-drivers        # Logi Options+ 用
brew tap dimentium/autoraise          # AutoRaise 用

casks=(
  google-chrome
  chatgpt
  cursor
  discord
  docker
  keyboardcleantool
  linearmouse
  logi-options+
  microsoft-remote-desktop
  kindle              # 不要ならコメントアウト
  notion
  obsidian
  raycast
  runcat
  slack
  spotify
  steam
  visual-studio-code
  zoom
  unity-hub
  dimentium/autoraise/autoraiseapp
)

for c in "${casks[@]}"; do
  if brew list --cask "$c" >/dev/null 2>&1; then
    echo "skip  $c (already installed)"
  else
    echo "install $c"
    brew install --cask "$c"
  fi
done
