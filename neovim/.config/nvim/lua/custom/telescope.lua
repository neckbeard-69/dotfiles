local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        file_ignore_patterns = { "%.png$", "%.jpg$", "%.jpeg$", "%.gif$", "%.svg$", "%.bmp$", "%.webp$", "node_modules" },
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
            },
        },
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
            },
        },
    },
})
local builtin = require("telescope.builtin")
local set = vim.keymap.set


set("n", "<leader>ff", builtin.find_files, {})
set("n", "<leader>fs", builtin.live_grep, {})
set("n", "<leader><leader>", builtin.oldfiles, {})
set("n", "<space>fg", builtin.git_files)
set("n", "<space>fh", builtin.help_tags)
set("n", "<space>fb", builtin.buffers)
set("n", "<space>fd", builtin.lsp_document_symbols)
set("n", "<space>fm", builtin.marks)
set("n", "<leader>fi", function()
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer" })

-- set("n", "<space>fg", require("custom.telescope.multi-ripgrep"))
