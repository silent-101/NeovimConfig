require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "tailwindcss", "pylsp", "ccls", "clangd" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 

-- Robust clangd setup: background indexing and completion capabilities
do
	-- Configure clangd using the new Nvim 0.11+ `vim.lsp.config` API
	-- This avoids the deprecated `require('lspconfig')` framework.
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- If you use a snippet engine (LuaSnip/etc), enable snippet support here:
	-- capabilities.textDocument = capabilities.textDocument or {}
	-- capabilities.textDocument.completion = capabilities.textDocument.completion or {}
	-- capabilities.textDocument.completion.completionItem = capabilities.textDocument.completion.completionItem or {}
	-- capabilities.textDocument.completion.completionItem.snippetSupport = true

	vim.lsp.config('clangd', {
		cmd = {
			"clangd",
			"--background-index",
			"--completion-style=detailed",
			"--clang-tidy",
			"--header-insertion=never",
			-- uncomment to enable verbose logging for debugging:
			-- "--log=verbose",
		},
		capabilities = capabilities,
		filetypes = { "c", "cpp", "objc", "objcpp" },
		-- Optionally: root_markers = { '.clangd', 'compile_commands.json' },
	})
	-- `vim.lsp.enable(servers)` earlier in this file will auto-start clangd when
	-- a matching buffer is opened (so no explicit start/require is needed here).
end
