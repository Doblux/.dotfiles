return {
	"ThePrimeagen/harpoon",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		local ui = require("harpoon.ui")
		local mark = require("harpoon.mark")
		local harpoon = require("harpoon")
		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
	end,
}
