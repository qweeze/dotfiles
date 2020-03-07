#!/usr/bin/env bash
set -euo pipefail

declare -a LINKS=(
  "vimrc"
  "vim"
  "tmux.conf"
)

DOTFILES_PATH=$(dirname "$(realpath "$0")")

for link in "${LINKS[@]}"; do
  if [ -L "$HOME/.$link" ]; then
    echo ".$link exists, skipping"
  else
    ln -s "$DOTFILES_PATH"/"$link" ~/."$link"
    echo "Linked created ~/.$link -> $DOTFILES_PATH/$link"
  fi
done
