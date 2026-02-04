return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      filters = {
        dotfiles = false,
        custom = { "^\\.git$", "^\\.DS_Store$" },
      },
      view = {
        width = 30,
      },
    }

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    vim.keymap.set('n', "<c-\\>", vim.cmd.NvimTreeToggle )
    vim.keymap.set('n', "<leader>f", vim.cmd.NvimTreeFindFile )
  end,
}
