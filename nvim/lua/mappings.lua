require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local function user_defined_condbp() require('dap').set_breakpoint(vim.fn.input("Breakpoint Condition: ")) end

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<Leader>dbt", "<Cmd>DapToggleBreakpoint<CR>", { desc = "Toggle DAP breakpoint"})
map("n", "<Leader>dbc", user_defined_condbp, { desc = "Create a conditional breakpoint" } )
map("n", "<Leader>dn", "<Cmd>DapNew<CR>")

map("n",
    "<Leader>ca",
    function() vim.lsp.buf.code_action() end,
    {desc = "LSP Code Action"}
)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory in floating Oil" })
-- Replaces NvChad's <C-n> (NvimTreeToggle); nvim-tree is still on <Leader>e
map("n", "<C-n>", function()
  require("oil").toggle_float(vim.fn.getcwd())
end, { desc = "Toggle floating Oil in the working directory" })
map("n", "<Leader>ot", "<cmd>Oil --float --trash /<CR>", { desc = "Open trash in Oil (move files out to restore)" })
