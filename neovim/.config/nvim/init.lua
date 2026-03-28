require("config.lazy")
require("config.options")
require("config.keymaps")
require("custom.snippets.go")
require("autocmd.macro")

vim.cmd([[
  hi Normal guibg=none ctermbg=none
  hi NormalNC guibg=none ctermbg=none
  hi NormalFloat guibg=none ctermbg=none
  hi FloatBorder guibg=none ctermbg=none
  hi SignColumn guibg=none ctermbg=none
  hi LineNr guibg=none ctermbg=none
  hi EndOfBuffer guibg=none ctermbg=none
]])
