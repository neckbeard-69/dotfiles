local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = false
opt.wrap = false
vim.o.mouse = "v"
-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

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

vim.g.transparent_enabled = true
function Enable_transparency()
	vim.cmd([[
        highlight Normal guibg=none
        highlight NonText guibg=none
        highlight Normal ctermbg=none
        highlight NonText ctermbg=none
    ]])
end

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*.js", "*.ts", "*.tsx", "*.jsx" },
-- 	callback = function()
-- 		require("conform").format()
-- 	end,
-- })
