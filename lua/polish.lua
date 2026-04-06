-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Ensure selected theme is applied even if another plugin loads later.
vim.schedule(function() pcall(vim.cmd.colorscheme, "astromars") end)

-- Highlight yanked text briefly for better visual feedback.
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	callback = function() vim.highlight.on_yank { higroup = "Visual", timeout = 180 } end,
})

-- Restore cursor to last position when reopening a file.
vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Restore cursor position",
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Keep files synchronized when changed outside of Neovim.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "TermClose", "TermLeave" }, {
	desc = "Auto checktime",
	callback = function()
		if vim.fn.mode() ~= "c" then vim.cmd "checktime" end
	end,
})

-- Fast close for utility windows.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "qf", "lspinfo", "man", "notify", "checkhealth" },
	callback = function(args)
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true })
	end,
})

-- Better terminal mode ergonomics.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
