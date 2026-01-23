local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = false
opt.wrap = false
opt.mouse = "v"
-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.signcolumn = "yes"
opt.winborder = "rounded"


opt.termguicolors = true
opt.background = "dark"

opt.scrolloff = 8

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.cmdheight = 0

opt.swapfile = false
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    desc = "Hightlight selection on yank",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
    end,
})

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1f1f1f" })

local color = vim.api.nvim_get_hl_by_name("Statusline", true).background

vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#000000", bold = true, bg = "#ffffff" })

vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#1f1f1f", bold = true })
