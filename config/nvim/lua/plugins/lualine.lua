-- lualine.lua
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    -- 1. ここでEldritch風の色を直接定義します
    -- (読み込みに失敗してもいいように、直接HEXコードを書きます)
    local colors = {
      bg       = 'NONE',    -- 透過
      fg       = '#ebfafa', -- 文字色(白系)
      purple   = '#a48cf2', -- Eldritchの紫
      cyan     = '#39ccdb', -- Eldritchのシアン
      darkblue = '#212337', -- 暗い青(文字の背景用)
      green    = '#a48cf2', -- Insertモード用(好みで変更可)
      orange   = '#f7c67f', -- Visualモード用
      violet   = '#a48cf2',
      magenta  = '#f265b5',
    }

    -- 2. テーマ設定をここで作ってしまいます
    local custom_eldritch = {
      normal = {
        a = { bg = colors.purple, fg = colors.darkblue, gui = 'bold' },
        b = { bg = 'NONE', fg = colors.purple },
        c = { bg = 'NONE', fg = colors.fg },
      },
      insert = {
        a = { bg = colors.cyan, fg = colors.darkblue, gui = 'bold' },
        b = { bg = 'NONE', fg = colors.cyan },
        c = { bg = 'NONE', fg = colors.fg },
      },
      visual = {
        a = { bg = colors.magenta, fg = colors.darkblue, gui = 'bold' },
        b = { bg = 'NONE', fg = colors.magenta },
        c = { bg = 'NONE', fg = colors.fg },
      },
      replace = {
        a = { bg = colors.orange, fg = colors.darkblue, gui = 'bold' },
        b = { bg = 'NONE', fg = colors.orange },
        c = { bg = 'NONE', fg = colors.fg },
      },
      command = {
        a = { bg = colors.green, fg = colors.darkblue, gui = 'bold' },
        b = { bg = 'NONE', fg = colors.green },
        c = { bg = 'NONE', fg = colors.fg },
      },
      inactive = {
        a = { bg = 'NONE', fg = colors.fg, gui = 'bold' },
        b = { bg = 'NONE', fg = colors.fg },
        c = { bg = 'NONE', fg = colors.fg },
      },
    }

    return {
      options = {
        icons_enabled = true,
        theme = custom_eldritch, -- 【重要】上で作った設定を直接渡す
        
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''}, 
        disabled_filetypes = { statusline = {}, winbar = {} },
        always_show_tabline = true,
        globalstatus = false,
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
          { 'filename', color = { bg = 'NONE' } } 
        },
        lualine_x = {
          { 'encoding', color = { bg = 'NONE' } },
          { 'fileformat', color = { bg = 'NONE' } },
          { 'filetype', color = { bg = 'NONE' } }
        },
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
    }
  end
}
