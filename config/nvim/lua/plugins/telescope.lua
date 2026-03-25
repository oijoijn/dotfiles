return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
        require('telescope').setup({})
    end,

    keys = {
        -- 基本の検索
        { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Telescope find files" },
        { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Telescope live grep" },
        { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Telescope buffers" },
        { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Telescope help tags" },
        { "<leader>fo", function() require("telescope.builtin").oldfiles() end, desc = "Telescope oldfiles" },

        -- ▼▼▼ ここに追加 ▼▼▼
        
        -- <leader>fv : 垂直分割 (Vertical Split) で開く検索
        { 
            "<leader>fv", 
            function() 
                require("telescope.builtin").find_files({
                    attach_mappings = function(_, map)
                        -- Enterキー (<CR>) の動作を「垂直分割」に上書き
                        map({ "i", "n" }, "<CR>", require("telescope.actions").select_vertical)
                        return true
                    end
                }) 
            end, 
            desc = "Find files (Vertical Split)" 
        },

        -- <leader>sp : 水平分割 (Split) で開く検索
        { 
            "<leader>fs", 
            function() 
                require("telescope.builtin").find_files({
                    attach_mappings = function(_, map)
                        -- Enterキー (<CR>) の動作を「水平分割」に上書き
                        map({ "i", "n" }, "<CR>", require("telescope.actions").select_horizontal)
                        return true
                    end
                }) 
            end, 
            desc = "Find files (Horizontal Split)" 
        },
    },
}
