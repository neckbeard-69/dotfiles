return {
    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.ai").setup()
            require("mini.statusline").setup()
            require("mini.surround").setup()
            require("mini.pairs").setup()
            require("mini.icons").setup()
        end,
    },
}
