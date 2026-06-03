-- rest-nvim.lua
return {
    "rest-nvim/rest.nvim",
    dependencies = {
        -- 'nvim-treesitter' の指定をテーブルで囲み、その中に opts を記述する
        {
            "nvim-treesitter/nvim-treesitter",
            opts = function(_, opts)
                -- 既存の ensure_installed がなければ作成
                opts.ensure_installed = opts.ensure_installed or {}
                -- http パーサーを追加
                vim.list_extend(opts.ensure_installed, { "http" })
                return opts
            end,
        },
    },
    keys = {
        { "<leader>rr", "<Cmd>Rest run<CR>", mode = {'n'}, desc = "Run request under thecursor" },
        { "<leader>rl", "<Cmd>Rest last<CR>", mode = {'n'}, desc = "Run last request" },
        { "<leader>rg", "<Cmd>Rest logs<CR>", mode = {'n'}, desc = "Edit logs file" },
        { "<leader>rc", "<Cmd>Rest cookies<CR>", mode = {'n'}, desc = "Edit cookies file" },
        { "<leader>re", "<Cmd>Rest env show<CR>", mode = {'n'}, desc = "Show dotenv file registered to current .http file" },
        { "<leader>rt", "<Cmd>Rest env select<CR>", mode = {'n'}, desc = "Select & register .env file with vim.ui.select()" },
    }
}
