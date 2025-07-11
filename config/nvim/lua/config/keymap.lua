local set = vim.keymap.set

-- Leader キーの設定
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- キーマップファイルを開く
set('n', '<Leader>m,', '<Cmd>edit ~/.config/nvim/lua/config/keymap.lua<CR>')
-- win
-- set('n', '<Leader>m,', '<Cmd>edit ~/AppData/Local/nvim/lua/config/keymap.lua<CR>')

-- 基本のキーマップ
set('i', 'jj', '<Esc>')
set('i', '<C-l>', '<C-o>x')

set('n', 'H', '^')
set('n', 'L', '$')
set('n', '<Leader>ya', '<Cmd>%y<CR>')
set('n', '<Leader>vap', 'gg<S-v>Gp')
set('n', '<Leader>vaa', 'gg<S-v>G')
set('n', '<Leader>m', '`')
set('n', 'G', 'Gzz')
set('n', 'n', 'nzz', { noremap = true, silent = true, desc = "Next search result (center)" })
set('n', 'N', 'Nzz', { noremap = true, silent = true, desc = "Previous search result (center)" })

set('v', 'H', '^')
set('v', 'L', '$')

-- 保存
set('n', '<leader>w', '<Cmd>w<CR>')
set('n', '<leader>q', '<Cmd>q<CR>')
set('n', '<leader>k', '<Cmd>q!<CR>')
set('n', '<leader>x', '<Cmd>x<CR>')
set('n', '<leader>ac', '<Cmd>qa<CR>')

-- 画面操作
set('n', '<C-h>', 'gT')
set('n', '<C-l>', 'gt')
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')

-- un分割
set('n', '<leader>wt', '<C-w><S-t>')
set('n', '<leader>vs', '<C-w>v')
set('n', '<leader>sp', '<C-w>s')

-- tab
set("n", "[t", "<Cmd>tabmove -1<CR>", { desc = "Tab ←" })
set("n", "]t", "<Cmd>tabmove +1<CR>", { desc = "Tab →" })
-- buffer
set("n", "[b", "<Cmd>bprevious<CR>", { desc = "Prev buffer" })
set("n", "]b", "<Cmd>bnext<CR>",    { desc = "Next buffer" })

-- nvimの調査
set('n', '<leader>hh', '<Cmd>checkhealth<CR>')
set('n', '<leader>hl', '<Cmd>Lazy<CR>')
set('n', '<leader>hm', '<Cmd>Mason<CR>')

-- ヤンクの挙動
set('n', '<leader>dp', 'ms<Cmd>lua vim.cmd("%s/\\r//g")<CR>`s', {desc='delete ^M', noremap = true, silent = true })
set('n', '<S-y>','y$')

-- 矩形
set('n', '<C-A-v>', '<C-v>', {desc='Keymap change visual mode'})

-- delete
set('n', '<leader>da', '<Cmd>%d<CR>', {desc='All delete'})

-- terminal mode
set('t', '<C-[>', [[<C-\><C-n>]], { desc = 'Exit terminal job mode' })

-- number
set('n', '<leader>nn', '<Cmd>set number!<CR>', { desc = "Toggle line numbers" })

-- window sizeを均等にする
set('n', '<leader>w=', '<C-w>=', { noremap = true, silent = true })

-- 大文字小文字変換
set('n', '<leader>gu', 'g~')

-- 移動
set('n', '<C-o>', '<C-o>zz')
set('n', '<C-i>', '<C-i>zz')
set('n', 'n', 'nzz')

