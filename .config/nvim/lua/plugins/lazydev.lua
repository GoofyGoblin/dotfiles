-- lua/plugins/lazydev.lua
return {
  "folke/lazydev.nvim",
  ft = "lua",           -- load when opening a Lua file
  cmd = "LazyDev",      -- also load on :LazyDev
  keys = { { "<leader>ld", "<cmd>LazyDev<cr>", desc = "LazyDev" } }, -- optional mapping
  opts = {
    library = {
      -- keep these as examples; "${3rd}" is a template string some configs use.
      -- You can replace with an explicit path if needed.
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "LazyVim",              words = { "LazyVim" } },
      { path = "snacks.nvim",          words = { "Snacks" } },
      { path = "lazy.nvim",            words = { "LazyVim" } },
    },
  },
}

