-- keymap
--------------------------------------------------------------------------------
-- Navigate visual lines
vim.keymap.set({ 'n', 'x' }, 'j', 'gj', { desc = 'Navigate down (visual line)' })
vim.keymap.set({ 'n', 'x' }, 'k', 'gk', { desc = 'Navigate up (visual line)' })
vim.keymap.set({ 'n', 'x' }, '<Down>', 'gj', { desc = 'Navigate down (visual line)' })
vim.keymap.set({ 'n', 'x' }, '<Up>', 'gk', { desc = 'Navigate up (visual line)' })
vim.keymap.set('i', '<Down>', '<C-\\><C-o>gj', { desc = 'Navigate down (visual line)' })
vim.keymap.set('i', '<Up>', '<C-\\><C-o>gk', { desc = 'Navigate up (visual line)' })
-- Move Lines
-- vim.keymap.set({ 'n', 'x' }, '<M-S-Up>', ':move -2<cr>', { desc = 'Move Line Up' })
-- vim.keymap.set({ 'n', 'x' }, '<M-S-Down>', ':move +1<cr>', { desc = 'Move Line Down' })
-- vim.keymap.set('i', '<M-S-Up>', '<C-o>:move -2<cr>', { desc = 'Move Line Up' })
-- vim.keymap.set('i', '<M-S-Down>', '<C-o>:move +1<cr>', { desc = 'Move Line Down' })

-- Easier interaction with the system clipboard
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard after the cursor position' })
vim.keymap.set({ 'n', 'x' }, '<leader>P', '"+P', { desc = 'Paste from system clipboard before the cursor position' })

-- window navigation
--
vim.keymap.set('n', 'H', '<c-w>h')
vim.keymap.set('n', 'J', '<c-w>j')
vim.keymap.set('n', 'K', '<c-w>k')
vim.keymap.set('n', 'L', '<c-w>l')

-- Navigating buffers
vim.keymap.set('n', '<leader>bb', '<C-^>', { desc = 'Switch to alternate buffer' })
vim.keymap.set('n', '<leader><Tab>', '<C-^>', { desc = 'Switch to alternate buffer' })

vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprevious<cr>', { desc = 'Previous buffer' })

-- Ctrl-L redraws the screen by default. Now it will also toggle search highlighting.
vim.keymap.set('n', '<C-l>', ':set hlsearch!<cr><C-l>', { desc = 'Toggle search highlighting' })

-- Toggle visible whitespace characters
vim.keymap.set('n', '<leader>l', ':listchars!<cr>', { desc = 'Toggle [l]istchars' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Quickly source current file / execute Lua code
vim.keymap.set('n', '<leader>xx', '<Cmd>source %<CR>', { desc = 'Source current file' })
vim.keymap.set('n', '<leader>x', '<Cmd>:.lua<CR>', { desc = 'Lua: execute current line' })
vim.keymap.set('v', '<leader>x', '<Cmd>:lua<CR>', { desc = 'Lua: execute current selection' })

vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlighting", silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart config :restart)" })

-- native undotree
vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })

vim.keymap.set("n", "<leader>ft", "<cmd>NvimTreeToggle<cr>")

vim.keymap.set("n", "<C-s>", ":w<cr>")

vim.keymap.set("n", "gs","<C-w>]")
vim.keymap.set("n", "gv","<C-w>v<C-]>")

vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>qa", ":qa<cr>")
vim.keymap.set("n", "<C-s>", ":w<cr>")
