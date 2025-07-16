local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- require('lspconfig').solargraph.setup({})
-- require('lspconfig').hls.setup({})

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here 
  -- with the ones you want to install
  -- haskell lsp --> hls
  ensure_installed = {'lua_ls'},
  handlers = {
    lsp_zero.default_setup,
  },
})
