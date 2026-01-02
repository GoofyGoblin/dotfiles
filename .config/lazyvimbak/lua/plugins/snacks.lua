return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      },
      dashboard = {
        enabled = false,
        preset = {
          header = {
            " ",
          },
          -- You can change the default keys/menu items
          keys = {
            { icon = "🚀", key = "f", desc = "Find File", action = "Snacks.picker.find_files()" },
            { icon = "🔎", key = "r", desc = "Recent Files", action = "Snacks.picker.old_files()" },
            { icon = "📁", key = "p", desc = "Projects", action = "Snacks.picker.projects()" },
            -- Add your own custom keymaps
            { icon = "⚙️", key = "c", desc = "Open Config", action = "LazyVim.config()" },
            { icon = "🚪", key = "q", desc = "Quit Neovim", action = ":qa<CR>" },
          },
        },
      },
    },
  },
}
