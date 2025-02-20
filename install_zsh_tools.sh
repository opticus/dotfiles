#!/bin/bash

# Install Zsh
if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Installing..."
    sudo apt update
    sudo apt install -y zsh
else
    echo "Zsh is already installed."
fi

# Install Git
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing..."
    sudo apt install -y git
else
    echo "Git is already installed."
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is not installed. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Install zsh-autosuggestions plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "zsh-autosuggestions plugin is not installed. Installing..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions plugin is already installed."
fi

# Install zsh-syntax-highlighting plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "zsh-syntax-highlighting plugin is not installed. Installing..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting plugin is already installed."
fi

# Install fzf from Git repository
if ! command -v fzf &> /dev/null; then
    echo "fzf is not installed. Installing from Git repository..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
else
    echo "fzf is already installed."
fi

# Install Starship prompt
if ! command -v starship &> /dev/null; then
    echo "Starship prompt is not installed. Installing..."
    curl -sS https://starship.rs/install.sh | sh
else
    echo "Starship prompt is already installed."
fi

# Set Zsh as the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting Zsh as the default shell."
    chsh -s $(which zsh)
else
    echo "Zsh is already the default shell."
fi

echo "Installation complete. Please restart your terminal to apply the changes."
