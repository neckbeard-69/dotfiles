vim.pack.add({
	"https://github.com/nvim-neotest/neotest",

	-- dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/nvim-neotest/neotest-go",
	"https://github.com/ibhagwan/fzf-lua",
})

local neotest = require("neotest")
local fzf = require("fzf-lua")

neotest.setup({
	adapters = {
		require("neotest-go"),
	},
})

local function run_nearest()
	neotest.run.run()
	neotest.output_panel.open()
	vim.cmd("wincmd j")
end

local function run_file()
	neotest.run.run(vim.fn.expand("%"))
	neotest.output_panel.open()
	vim.cmd("wincmd j")
end

vim.keymap.set("n", "<leader>tt", run_nearest)
vim.keymap.set("n", "<leader>ta", run_file)
vim.keymap.set("n", "<leader>to", function()
	neotest.output_panel.toggle()
end)

local function neotest_picker()
	local items = {
		{ name = "Run nearest test",    fn = run_nearest },
		{ name = "Run file tests",      fn = run_file },
		{ name = "Toggle output panel", fn = function() neotest.output_panel.toggle() end },
		{ name = "Stop tests",          fn = function() neotest.run.stop() end },
	}

	fzf.fzf_exec(
		vim.tbl_map(function(item)
			return item.name
		end, items),
		{
			prompt = "Neotest ❯ ",
			actions = {
				["default"] = function(selected)
					for _, item in ipairs(items) do
						if item.name == selected[1] then
							item.fn()
							break
						end
					end
				end,
			},
		}
	)
end

vim.keymap.set("n", "<leader>ft", neotest_picker)
