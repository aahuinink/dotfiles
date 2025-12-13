require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 

-- clangd settings
vim.lsp.config.clangd = {
  cmd = {
    'clangd',
    '--completion-style=detailed',
    '--header-insertion=iwyu',
    '--clang-tidy',
    '--function-arg-placeholders=1',
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
    semanticHighlighting = true,
  }
}
