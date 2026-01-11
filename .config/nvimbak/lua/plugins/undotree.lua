-- lua/plugins/undotree.lua
return {
  "mbbill/undotree",
  cmd = "UndotreeToggle", -- only loads when this command is called
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
  },
  config = function()
    -- Optional settings for better UX
    vim.g.undotree_WindowLayout = 2       -- Split side-by-side
    vim.g.undotree_SplitWidth = 35        -- Width of the UndoTree window
    vim.g.undotree_SetFocusWhenToggle = 1 -- Focus when opened
  end,
}

