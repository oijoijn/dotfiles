return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },

    -- Telescope が読み込まれた後に実行される
    config = function(_, opts)
        local telescope                  = require("telescope")
        local actions                    = require("telescope.actions")

        -- opts は下で定義したテーブルが渡ってくる
        opts.defaults.mappings.i["<CR>"] = actions.select_tab
        opts.defaults.mappings.n["<CR>"] = actions.select_tab

        telescope.setup(opts)
    end,

    -- **純粋なデータ** だけにする。ここで `require` しない
    opts = {
        defaults = {
            mappings = { i = {}, n = {} },
        },
    },

    keys = {
        { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Telescope: find files" },
        { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Telescope: live grep" },
        { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Telescope: buffers" },
        { "<leader>fh", function() require("telescope.builtin").help_tags() end,  desc = "Telescope: help tags" },
    },
}
