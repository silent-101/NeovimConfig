-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "vtsls",

        -- install formatters
        "stylua",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      opts.handlers = opts.handlers or {}
      opts.handlers.ts_ls = false
      opts.handlers.tsserver = false
    end,
  },
}
