#!/bin/bash

set -e

# ========================================
# アプリケーションのインストール
# ========================================
echo "Checking and installing required packages..."
echo "----------------------------------------"

# --- 0. 前提パッケージ (Oh My Zshのインストールに必要) ---
# curl
if ! command -v curl &> /dev/null; then
    echo "🚀 Installing curl..."
    sudo apt update
    sudo apt install -y curl
    echo "✅ curl has been installed."
fi
# git
if ! command -v git &> /dev/null; then
    echo "🚀 Installing git..."
    sudo apt update
    sudo apt install -y git
    echo "✅ git has been installed."
fi

# --- 1. Zsh ---
if command -v zsh &> /dev/null; then
    echo "✅ Zsh is already installed."
else
    echo "🚀 Installing Zsh..."
    sudo apt update
    sudo apt install -y zsh
    echo "✅ Zsh has been installed."
fi

# --- 2. Oh My Zsh ---
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "✅ Oh My Zsh is already installed."
else
    echo "🚀 Installing Oh My Zsh..."
    # --unattended オプションで、対話なしにインストールを実行
    # インストール後にデフォルトシェルも自動でZshに変更されます
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "✅ Oh My Zsh has been installed."
fi

# --- 3. tmux (snap) ---
if snap list tmux &> /dev/null; then
    echo "✅ tmux (snap) is already installed."
else
    echo "🚀 Installing tmux via snap..."
    sudo snap install tmux --classic
    echo "✅ tmux (snap) has been installed."
fi

# --- 4. Neovim (snap) ---
if snap list nvim &> /dev/null; then
    echo "✅ Neovim (snap) is already installed."
else
    echo "🚀 Installing Neovim via snap..."
    sudo snap install nvim --classic
    echo "✅ Neovim (snap) has been installed."
fi

echo "----------------------------------------"
echo "Package installation finished."
echo "========================================"
npm install -g @devcontainers/cli
