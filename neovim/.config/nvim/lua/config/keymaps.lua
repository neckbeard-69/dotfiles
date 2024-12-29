local keymap = vim.keymap

keymap.set({ "i" }, "jk", "<ESC>", { desc = "Go to normal mode" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>sx", "<cmd>close<CR>")
-- panes navigation
keymap.set("n", "<A-h>", ":wincmd h<CR>")
keymap.set("n", "<M-j>", function()
    if vim.opt.diff:get() then
        vim.cmd([[normal! ]c]])
        return
    end
    vim.cmd([[m .+1<CR>==]])
end)

keymap.set("n", "<A-k>", function()
    if vim.opt.diff:get() then
        vim.cmd([[normal! [c]])
        return
    end
    vim.cmd([[m .-2<CR>==]])
end)
keymap.set("n", "<A-l>", ":wincmd l<CR>")
keymap.set("n", "<leader>a", "<C-a>") -- doesn't work with tmux
keymap.set("n", "<leader>x", "<C-x>") -- doesn't work with tmux
keymap.set("i", "<A-h>", "<Esc>:wincmd h<CR>")
keymap.set("i", "<A-k>", "<Esc>:wincmd k<CR>")
keymap.set("i", "<A-j>", "<Esc>:wincmd j<CR>")
keymap.set("i", "<A-l>", "<Esc>:wincmd l<CR>")
-- Custom motions
keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
keymap.set("n", "y<C-j>", "yG", { desc = "Copy to the end of the file" })
keymap.set({ "n", "v" }, "<C-j>", "G", { desc = "Go to the end of the file" })
keymap.set("n", "d<C-j>", "dG", { desc = "Delete to the end of the file" })

keymap.set({ "n", "v" }, "<C-k>", "gg", { desc = "Go to the top of the file" })
keymap.set("n", "y<C-k>", "ygg", { desc = "Copy to the top of the file" })
keymap.set("n", "d<C-k>", "dgg", { desc = "Delete to the top of the file" })

keymap.set({ "n", "v" }, "<C-l>", "$", { desc = "Go to the end of the current line" })
keymap.set("n", "y<C-l>", "y$", { desc = "Copy to the end of the current line" })
keymap.set("n", "d<C-l>", "d$", { desc = "Delete to the end of the current line" })

keymap.set({ "n", "v" }, "<C-h>", "0", { desc = "Go to the start of the current line" })
keymap.set("n", "y<C-h>", "y0", { desc = "Copy to the start of the current line" })
keymap.set("n", "d<C-h>", "d0", { desc = "Delete to the start of the current line" })
keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")

keymap.set("n", "<C-s>", ":w<CR>")
keymap.set("i", "<C-s>", "<Esc>:w<CR>a")

keymap.set({ "n", "i", "v" }, "<C-z>", "")
keymap.set({ "v" }, "p", "P")
