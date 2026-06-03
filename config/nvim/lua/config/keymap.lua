local set = vim.keymap.set

-- Leader キーの設定 (通常はLazy読み込みの前に設定されている必要があります)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 変更の適応 ($MYVIMRC は init.lua を指します)
set('n', '<Leader>sr', '<Cmd>source $MYVIMRC<CR>', { desc = '[S]ource [R]eload Config' })

-- キーマップファイルを開く (OS非依存の書き方)
set('n', '<Leader>so', function() vim.cmd.edit(vim.fn.stdpath("config") .. "/lua/config/keymap.lua") end, { desc = 'Edit keymap.lua' })

-- 基本のキーマップ
set('i', 'jj', '<Esc>')
set('i', '<C-k>', '<C-o>x') -- 注意: LSP等のキーバインドと競合する可能性あり

set('n', 'H', '^')
set('n', 'L', '$')
set('n', '<Leader>vap', 'gg<S-v>Gp')
set('n', '<Leader>vaa', 'gg<S-v>G')
set('n', '<Leader>m', '`')

set('v', 'H', '^')
set('v', 'L', '$')

-- all
set('n', '<Leader>ya', '<Cmd>%y<CR>', { desc = 'All yank' })
set('n', '<leader>qa', '<Cmd>qa<CR>', { desc = 'All close' })
set('n', '<leader>da', '<Cmd>%d<CR>', { desc = 'All delete' })

-- 保存
set('n', '<leader>ww', '<Cmd>w<CR>')
set('n', '<leader>qq', '<Cmd>q<CR>')
set('n', '<leader>kk', '<Cmd>q!<CR>')
set('n', '<leader>x', '<Cmd>x<CR>')

-- コピペ (Visual modeでのpaste時にレジスタを汚さない設定)
set("x", "p", '"_dP')

-- 画面操作
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')

-- tab
-- docs -> desc に修正。
-- <leader>wt と <leader>tn が同じ挙動になっていますが意図通りならOK
set('n', '<leader>wt', '<C-w><S-t>', { desc = 'Window to Tab (分割を解除)'})
set('n', '<leader>tn', ':tabnew ', { desc = 'Tab New (ファイル名を指定して新規タブ)' })
set('n', '<leader>w=', '<C-w>=', { noremap = true, silent = true, desc = 'Tabのsizeを均一化' })
set('n', '<C-h>', 'gT')
set('n', '<C-l>', 'gt')
set('n', '<leader>vs', ':vsplit ')
set('n', '<leader>sp', ':split ')

-- buffer
set("n", "[b", "<Cmd>bprevious<CR>", { desc = "Prev buffer" })
set("n", "]b", "<Cmd>bnext<CR>", { desc = "Next buffer" })

-- nvimの調査
set('n', '<leader>hh', '<Cmd>checkhealth<CR>')
set('n', '<leader>hl', '<Cmd>Lazy<CR>')
set('n', '<leader>hm', '<Cmd>Mason<CR>')

-- yankの挙動
set('n', '<leader>dm', 'ms<Cmd>lua vim.cmd("%s/\\r//g")<CR>`s', { desc = 'delete ^M', noremap = true, silent = true })
set('n', '<S-y>', 'y$')
set('n', '<leader>y', '"ay')

-- pasteの挙動
set({ 'n', 'v' }, '<leader>p', '"ap')

-- 矩形
set('n', '<C-A-v>', '<C-v>', { desc = 'Keymap change visual mode' })

-- terminal mode
set('t', '<C-[>', [[<C-\><C-n>]], { desc = 'Exit terminal job mode' })

-- number
set('n', '<leader>nn', '<Cmd>set number!<CR>', { desc = "Toggle line numbers" })

-- 大文字小文字変換
set('n', '<leader>gu', 'g~')

-- 移動 (検索結果のセンタリング)
set('n', '<C-o>', '<C-o>zz')
set('n', '<C-i>', '<C-i>zz')
-- 下の重複していた n, N を統合
set('n', 'n', 'nzz', { noremap = true, silent = true, desc = "Next search result (center)" })
set('n', 'N', 'Nzz', { noremap = true, silent = true, desc = "Previous search result (center)" })

-- keymapの調査
set("n", "<leader>kn", ":verbose nmap ", { noremap = true, desc = "Check Normal-mode map" })
set("n", "<leader>kv", ":verbose vmap ", { noremap = true, desc = "Check Visual-mode map" })
set("n", "<leader>ki", ":verbose imap ", { noremap = true, desc = "Check Insert-mode map" })
set("n", "<leader>kx", ":verbose xmap ", { noremap = true, desc = "Check Visual-mode map (same as vmap)" })
set("n", "<leader>ks", ":verbose smap ", { noremap = true, desc = "Check Select-mode map" })
set("n", "<leader>kc", ":verbose cmap ", { noremap = true, desc = "Check Command-mode map" })

-- 外部コマンド
set("n", "<leader>ex", ":! ", { noremap = true, desc = "external command exec" })

-- filepath
set('n', '<leader>fp', function () require("oijoijn.path_creator").path() end ,{ desc = "add file path" })

-- creator_file
set("n", "<leader>fa", function () require("oijoijn.file_creator").file() end, {desc = "create file" })

-- キーマッピングの登録
set('n', '<leader>tr', function () require("oijoijn.tree_dir").open_tree_float() end, { noremap = true, silent = true, desc = "Show project tree" })
