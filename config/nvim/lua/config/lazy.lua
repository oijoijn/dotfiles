local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- { import = "plugins.bufferline" },
    -- { import = "plugins.close-buffers" },
    -- { import = "plugins.dashboard-nvim" },
    { import = "plugins.toggleterm" },
    { import = "plugins.Comment" },
    { import = "plugins.gitsigns" },
    { import = "plugins.lualine" },
    { import = "plugins.mini-indentscope" },
    { import = "plugins.neo-tree" },
    { import = "plugins.noice" },
    { import = "plugins.nvim-hlslens" },
    { import = "plugins.nvim-surround" },
    { import = "plugins.telescope" },
    { import = "plugins.which-key" },
    -- { import = "plugins.lsp.lsp" },
    { import = "plugins.scheme" },
    { import = "plugins.luasnip" },
    { "vim-jp/vimdoc-ja" },
  },
})
