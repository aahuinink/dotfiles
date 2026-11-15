local cmp = require "cmp"
local base = require "nvchad.configs.cmp"

-- <CR> just inserts a newline, cmp never intercepts it
base.mapping["<CR>"] = cmp.mapping(function(fallback)
  fallback()
end, { "i", "s" })

-- <S-CR> is the only key that accepts the selected suggestion
base.mapping["<S-CR>"] = cmp.mapping.confirm {
  behavior = cmp.ConfirmBehavior.Insert,
  select = true,
}

return base
