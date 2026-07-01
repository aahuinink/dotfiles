return {
    {
        "mfussenegger/nvim-dap",
        lazy = false,
        config = function()
            require("configs.nvim-dap")
        end,
    },
    { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
    require("lazydev").setup({
      library = { "nvim-dap-ui" },
    }),
}
