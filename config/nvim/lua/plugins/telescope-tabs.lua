return {
  {
    "LukasPietzschmann/telescope-tabs",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local tstabs = require('telescope-tabs')
      tstabs.setup({
        show_preview = true,
        entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
          local entry_string = table.concat(file_names, ', ')
          return string.format('%d: %s', tab_id, entry_string)
        end,
      })
      require('telescope').load_extension('telescope-tabs')
    end,

    -- ▼▼▼ ここを修正・追加 ▼▼▼
    keys = {
      -- 1. 既存の設定: タブ一覧を表示
      { 
        "<leader>fl", 
        function() require('telescope-tabs').list_tabs() end, 
        desc = "Telescope タブ一覧" 
      },

      -- 2. ★追加したい設定: 新規タブを作ってファイル検索
      {
        "<leader>fn",
        function()
          vim.cmd("tabnew") -- 先に空のタブを作る
          require("telescope.builtin").find_files() -- そこで検索を開く
        end,
        desc = "新規タブでファイルを開く"
      },
    },
  }
}
