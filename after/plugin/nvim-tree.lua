-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
 require("nvim-tree").setup()

vim.keymap.set('n', '<C-\\>', vim.cmd.NvimTreeToggle )


-- local function my_on_attach(bufnr)
--   local api = require "nvim-tree.api"
-- 
--   local function opts(desc)
--     return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
--   end
-- 
--   -- default mappings
--   api.config.mappings.default_on_attach(bufnr)
-- 
--   -- custom mappings
--    vim.keymap.set('n', 'ff', api.tree.focus(),        opts('Focus tree'))
--   -- vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
-- end
-- 
-- -- pass to setup along with your other options
-- require("nvim-tree").setup {
--   ---
--   on_attach = my_on_attach,
--   ---
-- }
