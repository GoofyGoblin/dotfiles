local vim = vim
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true
vim.g.mapleader = " "
vim.o.laststatus = 3
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
-- vim.o.expandtab = true
vim.o.signcolumn = "yes"
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.winborder = "rounded"
vim.o.undofile = true
vim.opt.autoindent = true
vim.opt.fillchars = { eob = " " }
vim.opt.list = true
vim.opt.listchars = {
    -- space = "·",
    tab = "» ",
    trail = "_",
    eol = "󰌑",
    extends = ">",
    precedes = "<",
}
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff992b", bold = true })
