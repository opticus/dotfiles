#!/bin/bash

# Use the current directory or a directory passed as an argument
REPO_DIR="${1:-$(pwd)}"
TARGET_DIR="$HOME"

# Ensure .config directory exists
mkdir -p "$TARGET_DIR/.config"

# Create symlinks for Zsh configuration
ln -sf "$REPO_DIR/.zshrc" "$TARGET_DIR/.zshrc"

# Create symlinks for Starship configuration
ln -sf "$REPO_DIR/starship.toml" "$TARGET_DIR/.config/starship.toml"

# Create symlink for eza configuration
ln -sf "$REPO_DIR/eza" "$TARGET_DIR/.config/eza"

# Create symlink for tmux configuration
ln -sf "$REPO_DIR/.tmux.conf" "$TARGET_DIR/.tmux.conf"

echo "Symlinks created successfully."
