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

vim.o.cmdheight = 0

opt.swapfile = false
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    desc = "Hightlight selection on yank",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
    end,
})
