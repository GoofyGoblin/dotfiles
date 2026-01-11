local map = vim.keymap.set
map("n", "<leader>u", require("undotree").toggle, { noremap = true, silent = true })
map("n", "<leader>q", ":q<CR>")
map("n", "<C-h>", "<C-w>h", { noremap = true })
map("n", "<C-j>", "<C-w>j", { noremap = true })
map("n", "<C-k>", "<C-w>k", { noremap = true })
map("n", "<C-l>", "<C-w>l", { noremap = true })
map("n", "<leader>wv", vim.cmd.vsplit)
map("n", "<leader>ws", vim.cmd.split)
map("n", "<C-Left>", function()
	vim.cmd("vertical resize -5")
end)

map("n", "<C-Right>", function()
	vim.cmd("vertical resize +5")
end)

map("n", "<C-Down>", function()
	vim.cmd("resize +5")
end)

map("n", "<C-Up>", function()
	vim.cmd("resize -5")
end)
-- codeium
map("i", "<C-f>", function()
	require("neocodeium").accept()
end)
map("i", "<C-w>", function()
	require("neocodeium").accept_word()
end)
map("i", "<C-a>", function()
	require("neocodeium").accept_line()
end)
map("i", "<C-e>", function()
	require("neocodeium").cycle_or_complete()
end)
map("i", "<C-r>", function()
	require("neocodeium").cycle_or_complete(-1)
end)
map("i", "<C-c>", function()
	require("neocodeium").clear()
end)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "H", "<gv")
map("v", "L", ">gv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- fzf
map("n", "<leader>ff", ':lua require("fzf-lua").files()<CR>')
map("n", "<leader>fg", ':lua require("fzf-lua").live_grep()<CR>')
map("n", "<leader>fb", ':lua require("fzf-lua").buffers()<CR>')
map("n", "<leader>fh", ':lua require("fzf-lua").oldfiles()<CR>')

-- oil
require("oil").setup()
map("n", "<leader>e", ":Oil<CR>")

-- lsp
map("n", "<leader>cf", vim.lsp.buf.format)
map("n", "<leader>cr", vim.lsp.buf.rename)

map("n", "<leader>p", function()
	require("plugin-view").open()
end)

vim.api.nvim_set_keymap(
	"n",
	"<leader>z",
	"<cmd>lua require'centerpad'.toggle{ leftpad = 20, rightpad = 20 }<cr>",
	{ silent = true, noremap = true }
)
-- vim.keymap.set("n", "<leader>l", require("leap").leap({ target_windows = { vim.fn.win_getid() } }))
-- vim.keymap.set("v", "<leader>l", require("leap").leap({ target_windows = { vim.fn.win_getid() } }))
