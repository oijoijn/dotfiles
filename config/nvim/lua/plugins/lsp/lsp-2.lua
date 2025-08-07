-- lua/plugins/lsp.lua

return {
  -- LSP と補完の基本設定
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- LSPが有効になった際にキーマップを設定するのを遅延させる
      vim.g.lsp_zero_delay_server_setup = true
    end,
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      -- lsp-zero が lspconfig の設定を管理
      local lsp_zero = require("lsp-zero")
      lsp_zero.on_attach(function(client, bufnr)
        -- lsp-zero のデフォルトキーマップを有効にする
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)
      require("mason-lspconfig").setup({
        -- ここでインストールしたいLSPサーバーを指定
        ensure_installed = {
          "tsserver",
          "eslint",
          "lua_ls",
          "rust_analyzer",
          "pyright",
        },
        handlers = {
          lsp_zero.default_setup,
        },
      })
    end,
  },

  -- Mason (LSPサーバーインストーラー)
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  -- 自動補完エンジン (nvim-cmp)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip", build = "make install_js" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
    },
    config = function()
      local cmp = require("cmp")
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        -- キーマップやUIなど、lsp-zero の推奨設定を使用
        mapping = lsp_zero.defaults.cmp_mappings(),
      })
    end,
  },
}
