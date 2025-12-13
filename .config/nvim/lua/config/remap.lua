vim.opt.guicursor = ""
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.g.snacks_animate = false
vim.o.showmode = false
vim.g.mapleader = " "
vim.o.laststatus = 3
vim.opt.fillchars = ""
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.keymap.set("n", "<leader>da", vim.cmd.Alpha)
vim.keymap.set("n", "<leader>sp", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>spp", vim.cmd.split)
vim.keymap.set("n", "<leader>e", function()
    vim.cmd("Oil")
end)
vim.keymap.set("n", "<leader>ec", function()
    vim.cmd("Oil ~/.config/nvim/lua")
end, { desc = "Open Oil" })
vim.keymap.set("i", "<A-f>", function()
    require("neocodeium").accept()
end)
vim.keymap.set("i", "<A-w>", function()
    require("neocodeium").accept_word()
end)
vim.keymap.set("i", "<A-a>", function()
    require("neocodeium").accept_line()
end)
vim.keymap.set("i", "<A-e>", function()
    require("neocodeium").cycle_or_complete()
end)
vim.keymap.set("i", "<A-r>", function()
    require("neocodeium").cycle_or_complete(-1)
end)
vim.keymap.set("i", "<A-c>", function()
    require("neocodeium").clear()
end)
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })
vim.keymap.set("n", "<C-h>", vim.cmd.TmuxNavigateLeft)
vim.keymap.set("n", "<C-j>", vim.cmd.TmuxNavigateDown)
vim.keymap.set("n", "<C-k>", vim.cmd.TmuxNavigateUp)
vim.keymap.set("n", "<C-l>", vim.cmd.TmuxNavigateRight)
vim.keymap.set("n", "<C-Left>", function()
    vim.cmd("vertical resize -5")
end)

vim.keymap.set("n", "<C-Right>", function()
    vim.cmd("vertical resize +5")
end)

vim.keymap.set("n", "<C-Down>", function()
    vim.cmd("resize -5")
end)

vim.keymap.set("n", "<C-Up>", function()
    vim.cmd("resize +5")
end)
local map = vim.keymap.set
local opts = { desc = "", noremap = true, silent = true }

-- Find files
map("n", "<leader>ff", function()
    require("telescope.builtin").find_files()
end, vim.tbl_extend("force", opts, { desc = "Telescope: Find Files" }))

-- Live grep
map("n", "<leader>fg", function()
    require("telescope.builtin").live_grep()
end, vim.tbl_extend("force", opts, { desc = "Telescope: Live Grep" }))

-- Buffers
map("n", "<leader>fb", function()
    require("telescope.builtin").buffers()
end, vim.tbl_extend("force", opts, { desc = "Telescope: Buffers" }))

-- Help tags
map("n", "<leader>fh", function()
    require("telescope.builtin").help_tags()
end, vim.tbl_extend("force", opts, { desc = "Telescope: Help Tags" }))

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "H", "<gv")
vim.keymap.set("v", "L", ">gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("v", "<leader>Y", '"+Y')

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>rp", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- tabs
vim.opt.showtabline = 1
vim.opt.tabline = ""
-- transparent tabline
vim.cmd([[
    hi TablineFill guibg=NONE ctermfg=242 ctermbg=NONE
]])

vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })

vim.keymap.set("n", "<leader>tm", ":tabmove<CR>", { desc = "Move tab" })
vim.keymap.set("n", "<leader>t>", ":tabmove +1<CR>", { desc = "Move tab right" })
vim.keymap.set("n", "<leader>t<", ":tabmove -1<CR>", { desc = "Move tab left" })
vim.keymap.set("n", "<leader>tt", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>", { desc = "Prev tab" })
-- ============================================================================
-- STATUSLINE
-- ============================================================================

-- -- Git branch function
-- local function git_branch()
--     local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
--     if branch ~= "" then
--         return "  " .. branch .. " "
--     end
--     return ""
-- end
--
-- -- File type with icon
-- local function file_type()
--     local ft = vim.bo.filetype
--     local icons = {
--         lua = "[LUA]",
--         python = "[PY]",
--         javascript = "[JS]",
--         html = "[HTML]",
--         css = "[CSS]",
--         json = "[JSON]",
--         markdown = "[MD]",
--         vim = "[VIM]",
--         sh = "[SH]",
--     }
--
--     if ft == "" then
--         return "  "
--     end
--
--     return (icons[ft] or ft)
-- end
--
-- -- LSP status
-- local function lsp_status()
--     local clients = vim.lsp.get_clients({ bufnr = 0 })
--     if #clients > 0 then
--         return "  LSP "
--     end
--     return ""
-- end
--
-- -- Word count for text files
-- local function word_count()
--     local ft = vim.bo.filetype
--     if ft == "markdown" or ft == "text" or ft == "tex" then
--         local words = vim.fn.wordcount().words
--         return "  " .. words .. " words "
--     end
--     return ""
-- end
--
-- -- File size
-- local function file_size()
--     local size = vim.fn.getfsize(vim.fn.expand("%"))
--     if size < 0 then
--         return ""
--     end
--     if size < 1024 then
--         return size .. "B "
--     elseif size < 1024 * 1024 then
--         return string.format("%.1fK", size / 1024)
--     else
--         return string.format("%.1fM", size / 1024 / 1024)
--     end
-- end
--
-- -- Mode indicators with icons
-- local function mode_icon()
--     local mode = vim.fn.mode()
--     local modes = {
--         n = "NORMAL",
--         i = "INSERT",
--         v = "VISUAL",
--         V = "V-LINE",
--         ["\22"] = "V-BLOCK", -- Ctrl-V
--         c = "COMMAND",
--         s = "SELECT",
--         S = "S-LINE",
--         ["\19"] = "S-BLOCK", -- Ctrl-S
--         R = "REPLACE",
--         r = "REPLACE",
--         ["!"] = "SHELL",
--         t = "TERMINAL",
--     }
--     return modes[mode] or "  " .. mode:upper()
-- end
--
-- _G.mode_icon = mode_icon
-- _G.git_branch = git_branch
-- _G.file_type = file_type
-- _G.file_size = file_size
-- _G.lsp_status = lsp_status
--
-- vim.cmd([[
--   highlight StatusLineBold gui=bold cterm=bold
-- ]])
--
-- -- Function to change statusline based on window focus
-- local function setup_dynamic_statusline()
--     vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
--         callback = function()
--             vim.opt_local.statusline = table.concat({
--                 "  ",
--                 "%#StatusLineBold#",
--                 "%{v:lua.mode_icon()}",
--                 "%#StatusLine#",
--                 " │ %f %h%m%r",
--                 "%{v:lua.git_branch()}",
--                 " │ ",
--                 "%{v:lua.file_type()}",
--                 " | ",
--                 "%{v:lua.file_size()}",
--                 " | ",
--                 "%{v:lua.lsp_status()}",
--                 "%=", -- Right-align everything after this
--                 "%l:%c  %P ", -- Line:Column and Percentage
--             })
--         end,
--     })
--     vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })
--
--     vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
--         callback = function()
--             vim.opt_local.statusline = "  %f %h%m%r │ %{v:lua.file_type()} | %=  %l:%c   %P "
--         end,
--     })
-- end
--
-- setup_dynamic_statusline()
-- dap

-- local dap = require("dap")
-- -- dap.adapters.php = {
-- --     type = "executable",
-- --     command = "node",
-- --     args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/php-debug-adapter/dist/debugAdapter.js" },
-- dap.adapters["pwa-node"] = {
-- 	type = "server",
-- 	host = "127.0.0.1",
-- 	port = 8080,
-- 	executable = {
-- 		command = "js-debug-adapter",
-- 		args = { "--debugServerPort", "8080" },
-- 	},
-- }
--
-- for _, language in ipairs({ "typescript", "javascript" }) do
-- 	dap.configurations[language] = {
-- 		{
-- 			name = "Launch file",
-- 			type = "pwa-node",
-- 			request = "launch",
-- 			program = "${file}",
-- 			cwd = "${workspaceFolder}",
-- 			runtimteExecutable = "node",
-- 			sourceMaps = true,
-- 			protocol = "inspector",
-- 			console = "integratedTerminal",
-- 		},
-- 	}
-- end
