return {
  "windwp/nvim-ts-autotag",
  lazy = false,
  -- make sure treesitter is loaded first
  after = "nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-ts-autotag").setup {
      -- Ensure plugin is active for these filetypes
      filetypes = { "html", "xml", "javascriptreact", "javascript", "typescriptreact", "tsx", "jsx" },
      -- Defaults
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = true, -- Auto close on trailing </

      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the global settings
      -- doesn't work well in a specific filetype
      per_filetype = {
        ["tsx"] = {
          enable_close = true,
        },
      },
    }
  end,
}
