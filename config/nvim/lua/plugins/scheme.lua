-- scheme.lua
return {
  "eldritch-theme/eldritch.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true, -- 透過設定
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },
  config = function(_, opts)
    require("eldritch").setup(opts)
    vim.cmd("colorscheme eldritch")
  end,
}
