vim.pack.add {
	"https://github.com/nvim-treesitter/nvim-treesitter",
}


vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		name = "nvim-treesitter",
		-- This 'load' function runs once the plugin is added to the path
		load = function(plug)
			vim.cmd.packadd(plug.spec.name)

			-- Move your setup logic inside here
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = { "go", "javascript", "html", "c", "cpp", "lua" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				-- ... rest of your textobjects config ...
			})
		end
	},
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})
