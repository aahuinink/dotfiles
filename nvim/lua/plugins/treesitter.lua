return {
  {
    -- NvChad v2.5 expects the `main` branch (its :TSInstallAll calls require("nvim-treesitter").install).
    -- The old `master` branch is archived and its queries crash on Neovim 0.12
    -- (e.g. markdown code-fence injections: "attempt to call method 'range'").
    -- `main` needs tree-sitter-cli >= 0.26.1 to build parsers (installed via Mason).
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- `main` does not support lazy-loading
  },
}
