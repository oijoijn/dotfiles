# My Dotfiles

dotfilesリポジトリ

## 管理対象

- zsh 
- tmux
- Neovim

## セットアップ方法

新しいマシンでセットアップするには、以下のコマンドを実行します。

```zsh
# 1. リポジトリをクローン
git clone git@github.com:oijoijn/dotfiles.git ~/dotfiles

# 2. ディレクトリを移動
cd ~/dotfiles

# 3. インストールスクリプトを実行
./install.sh

# 4. setup 設定ファイルがあればbakをとりシンボリックリンクを張る
./setup.sh up

# 5. setup シンボリックリンクの削除とbacの復帰
./setup.sh down
