return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- NvChad sets `defaults = { lazy = true }`, so the plugin needs a trigger to load.
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- no latex parser / utftex installed; re-enable if you add them
      latex = { enabled = false },
    },
  },
}
