return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#FFFFFF", bold = true })
    end)

    require("ibl").setup({
      indent = {
        char = "│",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        highlight = "IblScope",
        include = {
          node_type = {
            ruby = {
              "class",
              "singleton_class",
              "module",
              "method",
              "singleton_method",
              "do_block",
              "if",
              "unless",
              "case",
              "while",
              "until",
              "for",
              "begin",
              "else",
              "array",
              "hash",
              "argument_list",
              "call",
              "block",
              "parenthesized_statements",
            },
            json = {
              "object",
              "array",
            },
            lua = {
              "table_constructor",
              "function_definition",
              "if_statement",
              "for_statement",
              "while_statement",
            },
            ["*"] = {
              "array",
              "object",
              "arguments",
              "block",
            },
          },
        },
      },
    })
  end,
}
