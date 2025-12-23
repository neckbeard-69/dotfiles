return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol',
                delay = 100
            }
        })

        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#7a7a7a", italic = true })

        vim.keymap.set("n", "<leader>gb", function()
            -- require("gitsigns").blame_line({ full = true })
            require("gitsigns").toggle_current_line_blame()
        end)
    end,
}
