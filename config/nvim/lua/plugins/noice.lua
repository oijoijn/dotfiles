return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },

  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },

    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },

    -- :! などの出力を拾うルート
    routes = {
      -- :!cmd の stdout / stderr をポップアップで表示
      {
        view = "popup", -- "split" にすると分割表示
        filter = {
          event = "msg_show",
          kind = { "shell_out", "shell_err" },
        },
      },

      -- 終了コード(任意)
      {
        view = "notify",
        filter = {
          event = "msg_show",
          kind = "shell_ret",
        },
      },

      -- 実行したコマンド文字列(:!xxx)自体は邪魔ならスキップ(任意)
      {
        opts = { skip = true },
        filter = {
          event = "msg_show",
          kind = "shell_cmd",
        },
      },

      -- 検索失敗などの警告/エラーも拾う
      {
        view = "notify",
        filter = { event = "msg_show", kind = "wmsg" },
      },
      {
        view = "notify",
        filter = { event = "msg_show", kind = "emsg" },
      },
    },
  },

  config = function(_, opts)
    require("noice").setup(opts)

    vim.keymap.set("n", "<Leader>nh", "<Cmd>Noice history<CR>", { desc = "Noice履歴" })
    vim.keymap.set("n", "<Leader>nd", "<Cmd>Noice dismiss<CR>", { desc = "Noice通知を消去" })

    -- 任意：デバッグ確認用
    -- vim.keymap.set("n", "<Leader>nh", "<Cmd>Noice log<CR>", { desc = "Noice log" })
  end,
}
