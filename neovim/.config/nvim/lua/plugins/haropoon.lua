return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()
        local set = vim.keymap.set
        set("n", "<leader>hm", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
        set("n", "<leader>ha", function()
            harpoon:list():add()
        end)
        set("n", "<leader>j", function()
            harpoon:list():next({ ui_nav_wrap = true })
        end)
        set("n", "<leader>k", function()
            harpoon:list():prev({ ui_nav_wrap = true })
        end)

        for i = 1, 9 do
            set("n", string.format("<leader>%d", i), function()
                harpoon:list():select(i)
            end)
        end
    end,
}
