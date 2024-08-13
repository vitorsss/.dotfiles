vim.filetype.add({
	extension = {
		base = function(path)
			local pathParts = vim.split(path, ".", { plain = true })
			return vim.filetype.match({ filename = "some." .. pathParts[#pathParts - 1] })
		end,
	},
})
