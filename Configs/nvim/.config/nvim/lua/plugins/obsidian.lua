return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- use latest release, remove to use latest commit
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false, -- this will be removed in 4.0.0
		daily_notes = {
			folder = "daily",
		},
		link = {
			auto_update = true,
			format = "shortest",
			style = "markdown",
		},
		workspaces = {
			{
				name = "notes",
				path = "~/.notes",
			},
		},
	},
}
