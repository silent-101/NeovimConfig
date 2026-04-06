---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = function(_, opts)
      opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
        trigger = {
          prefetch_on_insert = false,
          show_on_keyword = true,
          show_on_trigger_character = true,
          show_on_insert = false,
        },
        menu = {
          auto_show = true,
          border = "single",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        },
        documentation = {
          window = {
            border = "single",
          },
        },
      })

      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lsp = { fallbacks = { "buffer" } },
        },
      })

      opts.signature = vim.tbl_deep_extend("force", opts.signature or {}, {
        window = {
          border = "single",
        },
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },
}
