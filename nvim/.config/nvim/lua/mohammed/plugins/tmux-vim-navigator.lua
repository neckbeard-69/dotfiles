return {
    "christoomey/vim-tmux-navigator",
    vim.keymap.set("n", "<A-h>", ":TmuxNavigateLeft<CR>"),
    vim.keymap.set("n", "<A-l>", ":TmuxNavigateRight<CR>"),
}
