return{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            always_show_tabline  = true,
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = false,
            refresh = {
                statusline = 100,
                tabline = 100,
                winbar = 100,
            },
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'},
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              'tabs',
              mode = 1,          -- 1 = ファイル名（番号は不要なら 1 で OK）
              path = 0,          -- 0 = ファイル名のみ

              -- ▼ 省略させないためのパラメータ
              ----------------------------------------------------------
              -- 「各タブの長さ」 … 0 または十分大きい値に
              tab_max_length = 0,            -- 0 で無制限

              -- 「タブセクション全体の長さ」 … ウィンドウ幅に追従
              max_length = function()        -- 画面をリサイズしても自動追従
                return vim.o.columns         -- (= 現在のウィンドウ幅)
              end,
              ----------------------------------------------------------

              -- 省略記号を完全に消したいときは fmt で上書きも可
              -- fmt = function(name) return name end,
            },
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    }
}

