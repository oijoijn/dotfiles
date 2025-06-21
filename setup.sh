#!/bin/bash

# --- スクリプト設定 ---
# いずれかのコマンドが失敗した時点で、スクリプトを直ちに終了させます。
set -e

# --- 初期設定 ---
# このスクリプトがあるディレクトリの絶対パスを取得
DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)

# ========================================
# up: シンボリックリンクを作成する関数
# ========================================
setup_up() {
    echo "========================================"
    echo "Setting up dotfiles..."
    echo "----------------------------------------"

    # --- .zshrc ---
    if [ -e ~/.zshrc ] || [ -L ~/.zshrc ]; then
        echo "Backing up existing .zshrc to ~/.zshrc.bak"
        mv ~/.zshrc ~/.zshrc.bak
    fi
    echo "Linking .zshrc"
    ln -snf "$DOTFILES_DIR/config/zsh/zshrc" ~/.zshrc

    # --- .zsh_aliases ---
    if [ -e ~/.zsh_aliases ] || [ -L ~/.zsh_aliases ]; then
        echo "Backing up existing .zsh_aliases to ~/.zsh_aliases.bak"
        mv ~/.zsh_aliases ~/.zsh_aliases.bak
    fi
    echo "Linking .zsh_aliases"
    ln -snf "$DOTFILES_DIR/config/zsh/zsh_aliases" ~/.zsh_aliases

    # --- .zsh_export ---
    if [ -e ~/.zsh_export ] || [ -L ~/.zsh_export ]; then
        echo "Backing up existing .zsh_aliases to ~/.zsh_aliases.bak"
        mv ~/.zsh_export ~/.zsh_export.bak
    fi
    echo "Linking .zsh_aliases"
    ln -snf "$DOTFILES_DIR/config/zsh/zsh_export" ~/.zsh_export

    # --- .tmux.conf ---
    if [ -e ~/.tmux.conf ] || [ -L ~/.tmux.conf ]; then
        echo "Backing up existing .tmux.conf to ~/.tmux.conf.bak"
        mv ~/.tmux.conf ~/.tmux.conf.bak
    fi
    echo "Linking .tmux.conf"
    ln -snf "$DOTFILES_DIR/config/tmux/tmux.conf" ~/.tmux.conf

    # --- nvim config ---
    mkdir -p ~/.config
    if [ -e ~/.config/nvim ] || [ -L ~/.config/nvim ]; then
        echo "Backing up existing nvim config to ~/.config/nvim.bak"
        mv ~/.config/nvim ~/.config/nvim.bak
    fi
    echo "Linking nvim config"
    ln -snf "$DOTFILES_DIR/config/nvim" ~/.config/nvim

    echo "----------------------------------------"
    echo "🎉 Setup complete! Please restart your shell or run 'source ~/.zshrc'."
    echo "========================================"
}

# ========================================
# down: シンボリックリンクを削除し、バックアップを復元する関数
# ========================================
setup_down() {
    echo "========================================"
    echo "Tearing down dotfiles setup..."
    echo "----------------------------------------"

    # --- .zshrc ---
    if [ -L ~/.zshrc ]; then
        echo "Removing link for .zshrc"
        rm ~/.zshrc
    fi
    if [ -f ~/.zshrc.bak ]; then
        echo "Restoring .zshrc from backup"
        mv ~/.zshrc.bak ~/.zshrc
    fi

    # --- .zsh_aliases ---
    if [ -L ~/.zsh_aliases ]; then
        echo "Removing link for .zsh_aliases"
        rm ~/.zsh_aliases
    fi
    if [ -f ~/.zsh_aliases.bak ]; then
        echo "Restoring .zsh_aliases from backup"
        mv ~/.zsh_aliases.bak ~/.zsh_aliases
    fi

    # --- .zsh_aliases ---
    if [ -L ~/.zsh_export ]; then
        echo "Removing link for .zsh_export"
        rm ~/.zsh_export
    fi
    if [ -f ~/.zsh_export.bak ]; then
        echo "Restoring .zsh_export from backup"
        mv ~/.zsh_export.bak ~/.zsh_export
    fi

    # --- .tmux.conf ---
    if [ -L ~/.tmux.conf ]; then
        echo "Removing link for .tmux.conf"
        rm ~/.tmux.conf
    fi
    if [ -f ~/.tmux.conf.bak ]; then
        echo "Restoring .tmux.conf from backup"
        mv ~/.tmux.conf.bak ~/.tmux.conf
    fi

    # --- nvim config ---
    if [ -L ~/.config/nvim ]; then
        echo "Removing link for nvim config"
        rm ~/.config/nvim
    fi
    if [ -d ~/.config/nvim.bak ]; then # nvimはディレクトリなので -d でチェック
        echo "Restoring nvim config from backup"
        mv ~/.config/nvim.bak ~/.config/nvim
    fi

    echo "----------------------------------------"
    echo "🎉 Teardown complete! Please restart your shell."
    echo "========================================"
}

# ========================================
# ヘルプメッセージを表示する関数
# ========================================
usage() {
    echo "Usage: $0 {up|down}"
    echo "  up:   Create symbolic links and backup existing files."
    echo "  down: Remove symbolic links and restore from backups."
    exit 1
}

# ========================================
# メイン処理: 引数に応じて関数を呼び出す
# ========================================
case "$1" in
    up)
        setup_up
        ;;
    down)
        setup_down
        ;;
    *)
        usage
        ;;
esac
