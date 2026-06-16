require("mason").setup()

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Local buffer" })
vim.keymap.set("n", "df", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.diagnostic.config({ virtual_text = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})
vim.lsp.config('ts_ls', {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
})
-- Define the server configuration matching stylelint-language-server defaults
vim.lsp.config['stylelint_lsp'] = {
  cmd = { 'stylelint-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less', 'sass', 'vue', 'html' },
  root_markers = { '.stylelintrc', 'stylelint.config.js', 'package.json', '.git' },
  settings = {
    stylelintValidation = true,
  },
}
vim.lsp.enable({
  "lua_ls",
  "marksman",
  "ts_ls",
  "stylelint_lsp",
  "biome"
})

