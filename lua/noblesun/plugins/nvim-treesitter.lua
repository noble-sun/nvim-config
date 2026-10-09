return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-context" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
  config = function()
    local ts_context = require("treesitter-context")

    -- Limita o contexto sticky no topo da tela
    ts_context.setup({
      max_lines = 10, -- máximo de linhas no topo (ajuste conforme preferir)
      trim_scope = "outer", -- remove linhas internas primeiro (ex: comentários)
    })

    local parsers = {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline",
      "ruby",
      "haskell",
      "go",
      "javascript",
      "typescript",
      "html",
      "json",
    }

    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end
}
