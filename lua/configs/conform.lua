local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    python = { "black" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    -- Enable format on save
    enabled = true,
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
