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
  -- on_attach = function(client, bufnr)
  --   require("inlay-hints").on_attach(client, bufnr)
  -- end,
})
-- Define the server configuration matching stylelint-language-server defaults
vim.lsp.config['stylelint_lsp'] = {
  cmd = { 'stylelint-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less', 'sass', 'vue', 'html' },
  root_markers = { '.stylelintrc', 'stylelint.config.cjs', 'package.json', '.git' },
  settings = {
    stylelintValidation = true,
  },
}

vim.lsp.config['cssls'] = {
  filetypes = { "css", "scss", "less" },
  settings = {
      css = { validate = true },
      scss = { validate = true },
      less = { validate = true },
    },
}

vim.lsp.config['dprint'] = {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc", "markdown", "python", "toml", "rust", "roslyn", "graphql", "sass", "scss" }

}

-- vim.lsp.config['conform'] = {
--     event = { "BufWritePre" },
--     cmd = { "ConformInfo" },
--     keys = {
--         {
--             "<leader>f",
--             function()
--                 require("conform").format({ async = true, lsp_format = "never" })
--             end,
--             mode = "",
--             desc = "[F]ormat buffer",
--         },
--     },
--     opts = {
--         notify_on_error = false,
--         format_on_save = function(bufnr)
--             local lsp_format_opt = "never"
--             return {
--                 timeout_ms = 500,
--                 lsp_format = lsp_format_opt,
--             }
--         end,
--         formatters_by_ft = {
--             lua = { "stylua" },
--             javascript = { "biome", "biome-organize-imports" },
--             javascriptreact = { "biome", "biome-organize-imports" },
--             typescript = { "biome", "biome-organize-imports" },
--             typescriptreact = { "biome", "biome-organize-imports" },
--         },
--     },
-- }

vim.lsp.enable({
  "lua_ls",
  "marksman",
  "ts_ls",
  "stylelint_lsp",
  "biome",
  "dprint",
  -- "conform",
  "cssls",
  -- "somesass_ls"
})

