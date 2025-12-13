-- lua/plugins/harpoon.lua
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2", -- use the v2 branch
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy", -- lazy-load when needed
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED: initialize harpoon
    harpoon:setup()

    -- helper function for keymaps
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Add current file to harpoon list
    map("n", "<leader>a", function()
      harpoon:list():add()
    end, vim.tbl_extend("force", opts, { desc = "Harpoon: Add file" }))

    -- Toggle Harpoon quick menu
    map("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, vim.tbl_extend("force", opts, { desc = "Harpoon: Toggle menu" }))

    -- Jump to files 1–4 quickly
    map("n", "<leader>1", function() harpoon:list():select(1) end, vim.tbl_extend("force", opts, { desc = "Harpoon: File 1" }))
    map("n", "<leader>2", function() harpoon:list():select(2) end, vim.tbl_extend("force", opts, { desc = "Harpoon: File 2" }))
    map("n", "<leader>3", function() harpoon:list():select(3) end, vim.tbl_extend("force", opts, { desc = "Harpoon: File 3" }))
    map("n", "<leader>4", function() harpoon:list():select(4) end, vim.tbl_extend("force", opts, { desc = "Harpoon: File 4" }))

    -- Optional: previous / next file
    map("n", "<leader>p", function() harpoon:list():prev() end, vim.tbl_extend("force", opts, { desc = "Harpoon: Previous" }))
    map("n", "<leader>n", function() harpoon:list():next() end, vim.tbl_extend("force", opts, { desc = "Harpoon: Next" }))
  end,
}

