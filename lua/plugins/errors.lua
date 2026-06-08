return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup {
      preset = "nonerdfont",
      transparent_bg = false,
      transparent_cursorline = true,
      hi = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        arrow = "NonText",
        background = "CursorLine",
        mixing_color = "Normal",
      },
      disabled_ft = {},
      options = {
        show_source = {
          enabled = true,
          if_many = false,
        },
        use_icons_from_diagnostic = false,
        set_arrow_to_diag_color = false,
        throttle = 20,
        softwrap = 30,
        add_messages = {
          messages = true,
          display_count = false,
          use_max_severity = false,
          show_multiple_glyphs = true,
        },
        multilines = {
          enabled = true,
          always_show = true,
          trim_whitespaces = true,
          tabstop = 4,
          severity = nil,
        },
        show_all_diags_on_cursorline = true,
        show_diags_only_under_cursor = false,
        show_related = {
          enabled = true,
          max_count = 3,
        },
        enable_on_insert = true,
        enable_on_select = false,
        overflow = {
          mode = "wrap",
          padding = 0,
        },
        break_line = {
          enabled = false,
          after = 30,
        },
        format = nil,
        virt_texts = {
          priority = 2048,
        },
        severity = {
          vim.diagnostic.severity.ERROR,
          vim.diagnostic.severity.WARN,
          vim.diagnostic.severity.INFO,
          vim.diagnostic.severity.HINT,
        },
        overwrite_events = { "LspAttach", "DiagnosticChanged", "BufEnter", "CursorHold" },
        override_open_float = false,
      },
    }

    vim.diagnostic.config {
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = true,
    }

    local orig = vim.lsp.handlers["textDocument/publishDiagnostics"]
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      if result and result.diagnostics then
        local filtered = {}
        for _, d in ipairs(result.diagnostics) do
          local hide = false
          if d.source == "clangd" and type(d.message) == "string" and d.message:match("Included header .* is not used directly") then
            hide = true
          end
          if not hide then table.insert(filtered, d) end
        end
        result.diagnostics = filtered
      end
      return orig(err, result, ctx, config)
    end
  end,
}
