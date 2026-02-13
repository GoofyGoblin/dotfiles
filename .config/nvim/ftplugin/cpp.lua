vim.cmd([[
		set makeprg=cd\ build\ &&\ make\;
]])
vim.bo.filetype = "cpp"
pcall(vim.treesitter.start, 0)
vim.cmd("syntax off")
