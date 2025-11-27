return {
  -- Apply a conservative autopairs config for HTML/JSX/TSX to avoid
  -- conflicts with nvim-ts-autotag. This disables autopairs in those
  -- filetypes so autotag's behavior can be observed reliably.
  "windwp/nvim-autopairs",
  lazy = false,
  config = function()
    local ok, ap = pcall(require, "nvim-autopairs")
    if not ok then
      return
    end

    ap.setup {
      -- disable autopairs for tag-handling filetypes so autotag takes over
      disable_filetype = { "html", "xml", "javascriptreact", "javascript", "typescriptreact", "tsx", "jsx" },
    }
  end,
}
