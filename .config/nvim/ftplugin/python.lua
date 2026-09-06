vim.bo.filetype = "python"
pcall(vim.treesitter.start, 0)
vim.cmd("syntax off")
