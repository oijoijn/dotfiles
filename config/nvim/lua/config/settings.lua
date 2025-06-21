-- システムクリップボードを使用
vim.opt.clipboard:append{'unnamedplus'}

-- 行番号
vim.opt.number = true

-- タブとインデントの設定
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- 検索設定
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- neovimの環境
vim.g.python3_host_prog = '/home/so/.config/nvim/.neovim/bin/python3'
vim.g.ruby_host_prog = '/usr/local/bin/neovim-ruby-host'

-- スワップファイル無効
vim.opt.swapfile = false

-- バックアップファイル無効 (不要な場合は無効化)
vim.opt.backup = false

-- undo 履歴をファイルに保存 (有効推奨)
vim.opt.undofile = true

-- 上書き前のバックアップファイル無効 (基本不要)
vim.opt.writebackup = false

-- 24bit colorを有効
-- vim.opt.termguicolors = true

-- コメントアウトの色
vim.api.nvim_set_hl(0, "Comment", { fg = "#c2721a", italic = true })

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "Comment", { fg = "#c2721a", italic = true })
    end,
})

-- ターミナルモード
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        vim.opt_local.number = false          -- 絶対行番号を非表示にする
        vim.opt_local.relativenumber = false   -- 相対行番号を非表示にする
        vim.cmd("startinsert")                -- ターミナル起動時に自動的に insert mode にする
    end,
})
