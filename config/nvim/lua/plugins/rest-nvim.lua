return {
    "rest-nvim/rest.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            table.insert(opts.ensure_installed, "http")
        end,
    },
    keys = {
        { "<leader>rr", "<Cmd>Rest run<CR>", mode = {'n'}, desc = "Run request under the cursor" },
        { "<leader>rl", "<Cmd>Rest last<CR>", mode = {'n'}, desc = "Run last request" },
        { "<leader>rg", "<Cmd>Rest logs<CR>", mode = {'n'}, desc = "Edit logs file" },
        { "<leader>rc", "<Cmd>Rest cookies<CR>", mode = {'n'}, desc = "Edit cookies file" },
        { "<leader>re", "<Cmd>Rest env show<CR>", mode = {'n'}, desc = "Show dotenv file registered to current .http file" },
        { "<leader>rt", "<Cmd>Rest env select<CR>", mode = {'n'}, desc = "Select & register .env file with vim.ui.select()" },
    }
}
