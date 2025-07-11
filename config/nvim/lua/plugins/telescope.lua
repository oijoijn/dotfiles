return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        defaults = {
            mappings = {
                i = {
                    -- InsertモードでEnterキーを押したときのアクションを変更
                    ["<CR>"] = require("telescope.actions").select_tab,
                },
                n = {
                    -- NormalモードでEnterキーを押したときのアクションを変更
                    ["<CR>"] = require("telescope.actions").select_tab,
                },
            },
        },
    },
    keys = {
        { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Telescope: find files" },
        { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Telescope: live grep" },
        { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Telescope: buffers" },
        { "<leader>fh", function() require("telescope.builtin").help_tags() end,  desc = "Telescope: help tags" },
    },
}
