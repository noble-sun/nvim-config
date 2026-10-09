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

### LSPs? (sem Mason, pensado para NixOS)

Essa configuração **não usa Mason**. Em um sistema NixOS os binários dos LSP
servers já são instalados pelo próprio Nix, então deixar o Mason baixar uma
segunda cópia só duplica trabalho (e geralmente nem funciona bem, por conta
do sandboxing/FHS do Nix). Em vez disso, `lspconfig.lua` assume que o binário
do server já está disponível no `$PATH` quando o nvim abre, e só chama
`vim.lsp.enable(...)` se `vim.fn.executable("algum-binario") == 1`.

Isso divide a origem dos servers em duas categorias:

 - **Ferramentas de editor** (ex: `lua-language-server`): instaladas
   globalmente via `home.nix`, disponíveis em qualquer shell.
 - **Ferramentas de projeto** (ex: `gopls`, `ruby-lsp`): instaladas no
   `shell.nix`/`flake.nix` de cada projeto e carregadas via `direnv` ao entrar
   na pasta. Assim, abrir o nvim fora de um projeto nunca tenta subir um LSP
   que não existe ali — o `executable()` simplesmente falha e o `enable` é
   pulado.

Para instalar um novo server:
 1. Garanta que o binário dele esteja no `$PATH` (via `home.nix` se for algo
    usado em qualquer projeto, ou via `shell.nix`/`flake.nix` do projeto +
    `direnv` se for específico de uma stack).
 2. Configure o server em `lua/noblesun/plugins/lsp/lspconfig.lua`:
    ```lua
    vim.lsp.config("lsp_name", {
        capabilities = capabilities,
    })

    if vim.fn.executable("binario-do-lsp") == 1 then
      vim.lsp.enable("lsp_name")
    end
    ```

Note também que esse plugin usa `lazy = false` em vez de carregar sob um
evento (`BufReadPre`/`BufNewFile`): ele precisa correr no startup, antes do
primeiro arquivo passado na linha de comando disparar seu próprio evento
`FileType` — senão o autocmd registrado por `vim.lsp.enable()` chega tarde e
o LSP nunca anexa nesse primeiro buffer.

**ruby_lsp** funciona com algumas ressalvas:
 - smart rename (<leader>rn) não está capturando o buffer para renomear.
 - references (<leader>gr) se confunde um pouco sobre o que capturar e não
   distingue bem variável local de global.
 - Só funciona depois que algumas dependências das gems do bundle são
   instaladas localmente, como `postgresql-devel` para a gem `pg`.

#### ToDo
 - Configure code formatter for languages
