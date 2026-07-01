require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<Leader>dt", "<Cmd>DapToggleBreakpoint<CR>")

map("n",
    "<Leader>ca",
    function() vim.lsp.buf.code_action() end,
    {desc = "LSP Code Action"}
)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
