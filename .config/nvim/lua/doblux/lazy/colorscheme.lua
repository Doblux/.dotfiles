-- return {
--   "rebelot/kanagawa.nvim",
--   priority = 1000,
--   config = function()
--     require('kanagawa').setup({})
--     --vim.cmd("colorscheme kanagawa-wave")
--     vim.cmd("colorscheme kanagawa-dragon")
--     --vim.cmd("colorscheme kanagawa-lotus")
--   end
-- }

return {
	"blazkowolf/gruber-darker.nvim",
	priority = 1000,
	config = function()
		require("gruber-darker").setup({})
		vim.cmd.colorscheme("gruber-darker")
	end,
}
