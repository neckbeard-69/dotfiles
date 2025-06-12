return {
    "neckbeard-69/color-converter.nvim",
    opts = {
        detect_entire_line = true,
    },
    config = function()
        local cc = require("color-converter")
        cc.setup({})

        vim.keymap.set("n", "<leader>cc", cc.cycle)
        vim.keymap.set("n", "<leader>cm", cc.pick)
    end,
}
