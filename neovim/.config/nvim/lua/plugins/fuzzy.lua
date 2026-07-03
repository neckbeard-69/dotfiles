vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf = require("fzf-lua")

fzf.setup({
	fzf_bin = "sk",
	ui_select = true,
	file_icons = "mini",
	fzf_colors = true,
})

vim.keymap.set("n", "<leader><leader>", fzf.oldfiles, { silent = true })

vim.keymap.set("n", "<leader>gg", fzf.grep, { silent = true })
vim.keymap.set("n", "<leader>gl", fzf.live_grep, { silent = true })
vim.keymap.set("n", "<leader>gb", fzf.grep_curbuf, { silent = true })
vim.keymap.set("n", "<leader>gw", fzf.grep_cword, { silent = true })
vim.keymap.set("n", "<leader>gW", fzf.grep_cWORD, { silent = true })
vim.keymap.set("n", "<leader>gq", fzf.grep_quickfix, { silent = true })
vim.keymap.set("n", "<leader>gp", fzf.grep_project, { silent = true })
vim.keymap.set("v", "<leader>gv", fzf.grep_visual, { silent = true })

vim.keymap.set("n", "<leader>ff", fzf.files, { silent = true })
vim.keymap.set("n", "<leader>fc", fzf.changes, { silent = true })
vim.keymap.set("n", "<leader>fs", fzf.colorschemes, { silent = true })
vim.keymap.set("n", "<leader>fh", fzf.helptags, { silent = true })
vim.keymap.set("n", "<leader>fk", fzf.keymaps, { silent = true })
vim.keymap.set("n", "<leader>fo", fzf.nvim_options, { silent = true })

vim.keymap.set("n", "<leader>p", fzf.builtin, { silent = true })
vim.keymap.set("n", "<leader>d", fzf.diagnostics_document, { silent = true })
vim.keymap.set("n", "<leader>D", fzf.diagnostics_workspace, { silent = true })
