return {
  {
    "tpope/vim-fugitive",
    config = function()
      -- Opens fugitive
      -- g? for command helpers
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
  }
}
