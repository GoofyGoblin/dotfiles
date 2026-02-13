local vim = vim
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
map("i", "<A-f>", function()
	require("neocodeium").accept()
end)
map("i", "<A-w>", function()
	require("neocodeium").accept_word()
end)
map("i", "<A-a>", function()
	require("neocodeium").accept_line()
end)
map("i", "<A-e>", function()
	require("neocodeium").cycle_or_complete()
end)
map("i", "<A-r>", function()
	require("neocodeium").cycle_or_complete(-1)
end)
map("i", "<A-c>", function()
	require("neocodeium").clear()
end)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "H", "<gv")
map("v", "L", ">gv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- telescope
map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")
map("n", "<leader>fb", ":Telescope buffers<CR>")
map("n", "<leader>fh", ":Telescope oldfiles<CR>")

-- mini files
map("n", "<leader>e", function()
require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end)

-- lsp
map("n", "<leader>cf", vim.lsp.buf.format)
map("n", "<leader>cr", vim.lsp.buf.rename)
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)



map("n", "<leader>p", function()
	require("plugin-view").open()
end)

vim.api.nvim_set_keymap(
	"n",
	"<leader>z",
	"<cmd>lua require'centerpad'.toggle{ leftpad = 30, rightpad = 30 }<cr>",
	{ silent = true, noremap = true }
)

-- tabs
map("n", "<leader>tn", ":tabnew<CR>")
map("n", "<leader>tc", ":tabclose<CR>")
map("n", "<S-Tab>", ":tabprevious<CR>")
map("n", "<Tab>", ":tabnext<CR>")

-- neogit
map("n", "<leader>gg", ":Neogit<CR>")
map("n", "<leader>gc", ":NeogitCommit<CR>")
map("n", "<leader>gr", ":NeogitResetState<CR>")
map("n", "<leader>gl", ":NeogitLog<CR>")

-- treesitter text objects
map({ "n", "x", "o" }, "]m", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "]]", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end)
-- You can also pass a list to group multiple queries.
map({ "n", "x", "o" }, "]o", function()
	require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm` or `folds.scm`
map({ "n", "x", "o" }, "]s", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
end)
map({ "n", "x", "o" }, "]z", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
end)

map({ "n", "x", "o" }, "]M", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "][", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end)

map({ "n", "x", "o" }, "[m", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "[[", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end)

map({ "n", "x", "o" }, "[M", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "[]", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end)

-- Go to either the start or the end, whichever is closer.
-- Use if you want more granular movements
map({ "n", "x", "o" }, "]d", function()
	require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
end)
map({ "n", "x", "o" }, "[d", function()
	require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
end)

-- multicursors
local mc = require("multicursor-nvim")
mc.setup()
map({ "n", "x" }, "<A-j>", function() mc.lineAddCursor(-1) end)
map({ "n", "x" }, "<A-k>", function() mc.lineAddCursor(1) end)
map({ "n", "x" }, "<leader>J", function() mc.lineSkipCursor(-1) end)
map({ "n", "x" }, "<leader>K", function() mc.lineSkipCursor(1) end)

-- Add or skip adding a new cursor by matching word/selection
map({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
map({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
map({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
map({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

-- Disable and enable cursors.
map({ "n", "x" }, "<c-q>", mc.toggleCursor)

mc.addKeymapLayer(function(layerSet)
	-- Select a different cursor as the main one.
	layerSet({ "n", "x" }, "<left>", mc.prevCursor)
	layerSet({ "n", "x" }, "<right>", mc.nextCursor)

	-- Delete the main cursor.
	layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

	-- Enable and clear cursors using escape.
	layerSet("n", "<esc>", function()
		if not mc.cursorsEnabled() then
			mc.enableCursors()
		else
			mc.clearCursors()
		end
	end)
end)

-- refactoring
map(
	{ "n", "x" },
	"<leader>rr",
	function() require('telescope').extensions.refactoring.refactors() end
)

map(
	"n",
	"<leader>rp",
	function() require('refactoring').debug.printf({below = true}) end
)

-- Print var

map({"x", "n"}, "<leader>rv", function() require('refactoring').debug.print_var() end)
-- Supports both visual and normal mode

map("n", "<leader>rc", function() require('refactoring').debug.cleanup({}) end)

