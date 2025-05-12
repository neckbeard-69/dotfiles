-- return {
--     "neckbeard-69/color-converter.nvim",
--     config = function()
--         local cc = require("color-converter")
--         vim.keymap.set("n", "<leader>cc", "<Plug>ColorConvertCycle")
--         vim.keymap.set("n", "<leader>cm", "<Plug>ColorConvertMenu")
--     end,
-- }

return {
    'NTBBloodbath/color-converter.nvim',
    opts = {},
    config = function()
        local cc = require("color-converter")
        cc.setup({})

        vim.keymap.set("n", "<leader>cc", cc.cycle)
        vim.keymap.set("n", "<leader>cm", cc.pick)
    end
}
