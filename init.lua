-- initialize everything on the directory when neovim opens
require("noblesun.config_opts")
require("noblesun.lazy")

-- config color theme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
