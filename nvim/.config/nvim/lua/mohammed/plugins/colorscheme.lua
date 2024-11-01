return {
    { "neanias/everforest-nvim" },
    { "projekt0n/caret.nvim" },
    {
        "catppuccin/nvim",
        config = function()
            require("catppuccin").setup({
                transparent_background = false,
            })
            vim.cmd("colorscheme kanagawa")
        end,
    },
    { "ellisonleao/gruvbox.nvim" },
    { "folke/tokyonight.nvim" },
    { "cpea2506/one_monokai.nvim" },
    {
        "loctvl842/monokai-pro.nvim",
        config = function()
            require("monokai-pro").setup({
                filter = "classic", -- classic | octagon | pro | machine | ristretto | spectrum
            })
        end,
    },
    {
        "rose-pine/neovim",
        config = function()
            require("rose-pine").setup({
                variant = "moon", -- auto, main, moon, or dawn
                dark_variant = "moon", -- main, moon, or dawn
                dim_inactive_windows = false,
                extend_background_behind_borders = true,
                styels = {
                    transparency = true,
                },
            })
        end,
    },
    { "AlexvZyl/nordic.nvim" },
    { "HoNamDuong/hybrid.nvim" },
    { "kaiuri/nvim-juliana" },
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none",
                            },
                        },
                    },
                },
            })
        end,
    },
}
