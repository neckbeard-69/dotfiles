return {
    -- 'brenoprata10/nvim-highlight-colors',
    "neckbeard-69/nvim-highlight-colors",
    branch = "add-oklch-support",
    config = function()
        require('nvim-highlight-colors').setup({})
    end
}
