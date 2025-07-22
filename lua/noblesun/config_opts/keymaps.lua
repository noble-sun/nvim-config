vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- when selected something in visual mode, press J or K to move it and ident
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep search results in the middle of split
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- if you want to replace a highlighted word with another one that is in the
-- clipper buffer, it does not override the clipboard
vim.keymap.set("x", "<leader>p", "\"_dP")

-- clip copied text to both vim and system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
-- vim.keymap.set("N", "<leader>Y", "\"+Y")

-- delete to void register so that it does not override clipboard content
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- open new split by pressing vv or ss
vim.keymap.set({"n", "v"}, "vv", "<C-w>v")
vim.keymap.set({"n", "v"}, "ss", "<C-w>s")


--toggle fullscreen pane and split pane
_G.fulscreen = false
function ToggleFullscreen()
  if _G.fullscreen then
    vim.cmd('wincmd =')
    _G.fullscreen = false
  else
    vim.cmd('wincmd |')
    _G.fullscreen = true
  end
end

vim.api.nvim_set_keymap('n', 'z', ':lua ToggleFullscreen()<CR>',
  { noremap = true, silent = true }
)

-- clear highlighted search
vim.keymap.set({"n", "v"}, "//", vim.cmd.nohlsearch)

-- working with tabs
-- would be nice to open a new tab with the current file
vim.keymap.set({"n", "v"}, "<leader>t", vim.cmd.tabnew)
vim.keymap.set({"n", "v"}, "<leader>tn", vim.cmd.tabnext)
vim.keymap.set({"n", "v"}, "<leader>tN", vim.cmd.tabprevious)
vim.keymap.set({"n", "v"}, "<leader>tc", vim.cmd.tabclose)

-- move bewteen the last file open in the buffer
vim.keymap.set("n", "<leader><leader>",  "<c-^>")

-- -- Show all diagnostics on current line in floating window
vim.api.nvim_set_keymap(
  'n', 'of', ':lua vim.diagnostic.open_float()<CR>', 
  { noremap = true, silent = true }
)
-- -- Go to next diagnostic (if there are multiple on the same line, only shows
-- -- one at a time in the floating window)
vim.api.nvim_set_keymap(
  'n', 'ofn', ':lua vim.diagnostic.goto_next()<CR>',
  { noremap = true, silent = true }
)
-- -- Go to prev diagnostic (if there are multiple on the same line, only shows
-- -- one at a time in the floating window)
vim.api.nvim_set_keymap(
  'n', 'ofp', ':lua vim.diagnostic.goto_prev()<CR>',
  { noremap = true, silent = true }
)

-- ADDITIONAL POSSIBLE MAPPINGS
-- manually resize pane
-- when going to class definition, open as a right split
-- move panes from right to left and up and down (do this for tmux panes is also nice)










-- vim.diagnostic.config({
--   virtual_text = false, -- Turn off inline diagnostics
-- })
-- 
-- -- Use this if you want it to automatically show all diagnostics on the
-- -- current line in a floating window. Personally, I find this a bit
-- -- distracting and prefer to manually trigger it (see below). The
-- -- CursorHold event happens when after `updatetime` milliseconds. The
-- -- default is 4000 which is much too long
-- --vim.cmd('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()')
-- vim.o.updatetime = 300
-- 
-- -- Show all diagnostics on current line in floating window
-- vim.api.nvim_set_keymap(
--   'n', '<Leader>d', ':lua vim.diagnostic.open_float()<CR>', 
--   { noremap = true, silent = true }
-- )
-- -- Go to next diagnostic (if there are multiple on the same line, only shows
-- -- one at a time in the floating window)
-- vim.api.nvim_set_keymap(
--   'n', '<Leader>n', ':lua vim.diagnostic.goto_next()<CR>',
--   { noremap = true, silent = true }
-- )
-- -- Go to prev diagnostic (if there are multiple on the same line, only shows
-- -- one at a time in the floating window)
-- vim.api.nvim_set_keymap(
--   'n', '<Leader>p', ':lua vim.diagnostic.goto_prev()<CR>',
--   { noremap = true, silent = true }
-- )
