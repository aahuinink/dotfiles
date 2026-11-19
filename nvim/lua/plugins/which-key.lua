return {
  {
    "folke/which-key.nvim",
    -- Load at startup so the y/c/d triggers below are ready before the first keypress
    event = "VeryLazy",
    opts = {
      triggers = {
        { "<auto>", mode = "nxso" },
        -- which-key never auto-triggers on single letters other than g/z/Z, so typing ys/cs/ds
        -- slower than 'timeoutlen' (400ms) fell back to a plain yank/change/delete.
        -- As manual triggers it waits for the next key (no timeout) and shows the surround hints.
        { "y", mode = "n" },
        { "c", mode = "n" },
        { "d", mode = "n" },
      },
      spec = {
        -- vim-surround's mappings have no descriptions
        { "ys", desc = "Add surrounding (motion)" },
        { "yss", desc = "Surround line" },
        { "yS", desc = "Add surrounding on new lines" },
        { "ySS", desc = "Surround line on new lines" },
        { "cs", desc = "Change surrounding" },
        { "cS", desc = "Change surrounding (new lines)" },
        { "ds", desc = "Delete surrounding" },
        { "S", mode = "x", desc = "Surround selection" },
        { "gS", mode = "x", desc = "Surround selection (new lines)" },
      },
    },
  },
}
