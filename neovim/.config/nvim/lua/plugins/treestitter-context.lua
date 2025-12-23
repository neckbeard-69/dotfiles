return {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
        vim.keymap.set({ "n", "v" }, "<leader>jc", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, { silent = true })
    end
}
