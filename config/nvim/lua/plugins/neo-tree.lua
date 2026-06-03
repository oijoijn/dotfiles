-- lua/plugins/neotree.lua
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",

    -- <Leader>e でトグル
    keys = {
        { "<Leader>e", "<Cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
    },

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    opts = {
        ------------------------------------------------------------------
        -- 1) ウィンドウ設定とキーマッピング
        ------------------------------------------------------------------
        window = {
            position = "left",
            width = 30,
            mappings = {
                -- l : ディレクトリは展開 / ファイルはタブで開いて自動クローズ
                ["l"]     = function(state)
                    local node = state.tree:get_node()
                    if node.type == "directory" then
                        require("neo-tree.sources.filesystem").toggle_directory(state)
                    else
                        state.commands.open_tab_drop(state) -- タブで開く
                        vim.schedule(function() -- 開いた直後に閉じる
                            require("neo-tree.command").execute({ action = "close" })
                        end)
                    end
                end,

                ["<cr>"]  = "open", -- Enter で普通に開く（イベントが発火する）
                ["<esc>"] = "cancel",
                ["P"]     = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
                ["u"]     = "focus_preview",
                ["S"]     = "open_split",
                ["s"]     = "open_vsplit",
                ["w"]     = "open_with_window_picker",
                ["C"]     = "close_node",
                ["z"]     = "close_all_nodes",
                ["a"]     = { "add", config = { show_path = "none" } },
                ["A"]     = "add_directory",
                ["d"]     = "delete",
                ["r"]     = "rename",
                ["b"]     = "rename_basename",
                ["y"]     = "copy_to_clipboard",
                ["x"]     = "cut_to_clipboard",
                ["p"]     = "paste_from_clipboard",
                ["c"]     = "copy",
                ["m"]     = "move",
                ["q"]     = "close_window",
                ["R"]     = "refresh",
                ["?"]     = "show_help",
                ["<"]     = "prev_source",
                [">"]     = "next_source",
                ["i"]     = "show_file_details",
            },
        },

        ------------------------------------------------------------------
        -- 2) ファイルを開く直前に全 Neo-tree を閉じるイベントハンドラ
        ------------------------------------------------------------------
        event_handlers = {
            {
                event = "file_open_requested", -- すべての open 系で発火
                handler = function()
                    require("neo-tree.command").execute({ action = "close" })
                end,
            },
        },
    },
}
