vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-l><C-l>", [[<C-\><C-N>:lua ClearTerm(0)<CR>]], { desc = "Clear terminal" })
vim.keymap.set("t", "<C-l><C-l><C-l>", [[<C-\><C-N>:lua ClearTerm(1)<CR>]], { desc = "Reset terminal" })

function ClearTerm(reset)
	vim.opt_local.scrollback = 1

	vim.api.nvim_command("startinsert")
	if reset == 1 then
		vim.api.nvim_feedkeys("reset", "t", false)
	else
		vim.api.nvim_feedkeys("clear", "t", false)
	end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, false, true), "t", true)

	vim.opt_local.scrollback = 10000
end

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
