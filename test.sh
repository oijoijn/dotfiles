#!/bin/bash
set -e
echo ">>>> Starting personal setup: Installing Neovim... <<<<"

# sudoが使えるかチェック
if ! command -v sudo &> /dev/null; then
    echo "sudo command not found. Installing without sudo."
    # sudoなしの場合のインストールパス（例: $HOME/.local/bin）
    mkdir -p $HOME/.local/bin
    curl -fL https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz | tar -xz -C $HOME/.local
    # nvim-linux64/binをパスに追加する必要がある
    echo 'export PATH="$HOME/.local/nvim-linux64/bin:$PATH"' >> $HOME/.bashrc
    export PATH="$HOME/.local/nvim-linux64/bin:$PATH"
else
    # sudoが使える場合（より一般的）
    curl -fL -o /tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
    sudo tar -xzf /tmp/nvim.tar.gz -C /opt/
    sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
    rm /tmp/nvim.tar.gz
fi

echo ">>>> Neovim installation complete. <<<<"
ln -snf "$HOME/config/devcontaner/devcontaner.json" ~/.config/dev-container-specifications/devcontainer.json
