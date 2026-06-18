-- globals
--
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
--------------------------------------------------------------------------------
-- Set <space> as leader key
-- NOTE: Must happen before loading plugins.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.g.netrw_banner = 0
vim.opt.nu = true
vim.opt.relativenumber = true

