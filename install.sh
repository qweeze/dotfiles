#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

IGNORE=(".git" ".gitignore" "install.sh" "README.md" ".config")

link() {
    local src="$1"
    local dst="$2"

    if [ -L "$dst" ]; then
        local current
        current="$(readlink "$dst")"
        if [ "$current" = "$src" ]; then
            echo "ok: $dst (already linked)"
        else
            echo "SKIP: $dst exists (symlink -> $current)"
        fi
    elif [ -e "$dst" ]; then
        echo "SKIP: $dst already exists"
    else
        ln -s "$src" "$dst"
        echo "linked: $dst -> $src"
    fi
}

is_ignored() {
    local name="$1"
    for ignored in "${IGNORE[@]}"; do
        [[ "$name" == "$ignored" ]] && return 0
    done
    return 1
}

# Link top-level dotfiles/dotdirs (e.g. .tmux.conf, .zshrc)
for item in "$DOTFILES_DIR"/.*; do
    name="$(basename "$item")"
    [[ "$name" == "." || "$name" == ".." ]] && continue
    is_ignored "$name" && continue
    link "$item" "$HOME/$name"
done

# Link .config/* children individually (e.g. alacritty, nvim)
if [ -d "$DOTFILES_DIR/.config" ]; then
    mkdir -p "$HOME/.config"
    for item in "$DOTFILES_DIR/.config"/*; do
        [ -e "$item" ] || continue
        name="$(basename "$item")"
        link "$item" "$HOME/.config/$name"
    done
fi
