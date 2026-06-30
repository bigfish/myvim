-- FILE: nvim/plugin/telescope.lua

-- AUTOCOMMANDS

-- WARN: This is a build for installation (and also update) step, so it must
--       come before adding the plugins in order to get triggered.
vim.api.nvim_create_autocmd('PackChanged', {
	desc = 'telescope: build extensions and setup it up in order',
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
			vim.system({ 'make' }, { cwd = ev.data.path })
		end
	end,
})

-- SETUP

vim.pack.add {
	-- Order matters to respect dependency tree.
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
}

require('telescope').setup {
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = 'smart_case',
		},
	},
}

require('telescope').load_extension 'fzf'

-- KEYMAPS

local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
