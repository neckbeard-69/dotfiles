return {
  "xiyaowong/transparent.nvim",
  event = "VeryLazy",
  config = function()
    require("transparent").clear_prefix("BufferLine")
    require("transparent").clear_prefix("NeoTree")
    vim.keymap.set("n", "<Leader>tt", ":TransparentToggle<CR>")
  end,
}
