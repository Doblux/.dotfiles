return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local custom_gruvbox = require("lualine.themes.auto")
		-- Change the background of lualine_c section for normal mode
		local auto_theme = require("lualine.themes.auto")
		custom_gruvbox.normal.c.bg = "#112233"
		require("lualine").setup({
			icons_enabled = true,
			options = { theme = auto_theme },
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		})
	end,
}
