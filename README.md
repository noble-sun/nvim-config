# Neovim Configuration

### Prerequisites
 - [neovim 0.11+](https://github.com/neovim/neovim/releases/tag/v0.11.0)

### How to use it?

After installing neovim, clone this repository on ~/.config/nvim with the command below
```bash
git clone git@github.com:noble-sun/nvim-config.git .
```

### Neovim configuration

Configurations like keybinds are located on '/lua/noblesun/config_opts/keymaps.lua'.
Configurations like tab size and leader key can be found on 'lua/noblesun/config_opts/options.lua'

### Want to install a new plugin?

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) as plugin manager.
Just create a new lua file with the name of the plugin under `/lua/noblesun/plugins` and return a table with the plugin repository and configurations:
```lua
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true
    vim.keymap.set('n', '<C-\\>', vim.cmd.NvimTreeToggle )
  end,
}
```

### LSPs?

So to install new servers for other languages:
 - Go to *mason.lua* on 'lua/noblesun/plugins/lsp/' to list the server name on *mason_lspconfig* to ensure the server is installed.
    - Or inside neovim open mason with `:Mason` and install the server manually.
 - Configure the lspconfig for the server on 'lua/noblesun/plugins/lsp/lspconfig.lua'
    ```lua
    -- basic configuration
    vim.lsp.config("lsp_name", {
        capabilities = require("cmp_nvim_lsp").default_capabilities()
    })
    ```

**ruby_lsp** works with a few caveats:
 - smart rename (<leader>rn) is not capturing the buffer to rename
 - references (<leader>gr) gets a bit mixed up on what capture and doesn't really understand local from global variables.
 - It only worked after some dependencies from the bundle gems were installed locally, like the `postgresql-devel` for the `pg` gem

#### ToDo
 - Configure code formatter for languages
