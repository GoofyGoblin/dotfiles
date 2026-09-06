local vim = vim
vim.cmd([[set noswapfile]])
vim.cmd("NeoCodeium disable");
vim.o.number = true
vim.o.relativenumber = true
-- vim.o.wrap = true
-- vim.o.breakindent = true
-- vim.o.linebreak = true
vim.o.wrap = false
vim.o.breakindent = false
vim.o.linebreak = false
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true
vim.g.mapleader = " "
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.colorcolumn = "80"
vim.o.signcolumn = "yes"
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.winborder = "rounded"
vim.o.undofile = true
vim.opt.syntax = off
vim.opt.autoindent = true
vim.opt.fillchars = { eob = " " }
vim.opt.listchars = {
    lead = "·",
    tab = "» ",
    trail = "_",
    extends = ">",
    precedes = "<",
}
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff992b", bold = true })
