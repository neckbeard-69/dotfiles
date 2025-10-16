local function show_macro_info(register)
    local buf = vim.api.nvim_create_buf(false, true)
    local width = 40
    local height = 1

    local win_width = vim.o.columns
    local win_height = vim.o.lines

    local opts = {
        relative = "editor",
        width = width,
        height = height,
        row = win_height - 5,
        col = win_width - width - 2,
        style = "minimal",
        border = "rounded",
    }

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Recording macro @" .. register })
    local win = vim.api.nvim_open_win(buf, false, opts)

    return win
end

local macro_win = nil

vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        local reg = vim.fn.reg_recording()
        macro_win = show_macro_info(reg)
    end
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
        if macro_win and vim.api.nvim_win_is_valid(macro_win) then
            vim.api.nvim_win_close(macro_win, true)
            macro_win = nil
        end
    end
})
