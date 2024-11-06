local actions = require("telescope.actions")

require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
			},
		},
	},
})
local builtin = require("telescope.builtin")
local set = vim.keymap.set

require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
require("telescope").load_extension("smart_history")
require("telescope").load_extension("ui-select")

set("n", "<leader>ff", builtin.find_files, {})
set("n", "<leader>fg", builtin.live_grep, {})
set("n", "<leader><leader>", builtin.oldfiles, {})
set("n", "<space>ft", builtin.git_files)
set("n", "<space>fh", builtin.help_tags)
set("n", "<space>fs", builtin.grep_string)
set("n", "<space>fb", builtin.buffers)
set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- set("n", "<space>fg", require("custom.telescope.multi-ripgrep"))
