return {
    {
        "mfussenegger/nvim-dap",
        lazy = false,
        config = function()
            require("configs.nvim-dap")
        end,
    },
    {
        "igorlfs/nvim-dap-view",
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {},
        dependencies = {
            'mfussenegger/nvim-dap',
        },
    },
}
