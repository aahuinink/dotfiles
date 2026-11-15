return {
    filters = {
        dotfiles = false,
        git_ignored = false,
    },
    -- Default mappings, but "d"/<Del> send to the trash (gio trash) instead of deleting permanently.
    -- Restore from oil with <Leader>ot (same freedesktop trash as oil's delete_to_trash).
    on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        api.map.on_attach.default(bufnr)

        local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
        vim.keymap.set({ "n", "x" }, "d", api.fs.trash, vim.tbl_extend("force", opts, { desc = "nvim-tree: Trash" }))
        vim.keymap.set({ "n", "x" }, "<Del>", api.fs.trash, vim.tbl_extend("force", opts, { desc = "nvim-tree: Trash" }))
    end,
}
