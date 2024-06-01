--return {
--        "folke/tokyonight.nvim",
--	config = function()
--		require("tokyonight").setup({
--			-- use the night style
--			style = "night",
--			transparent = true,
--			-- disable italic for functions
--			styles = {
--				functions = {}
--			},
--			sidebars = { "qf", "vista_kind", "terminal", "packer" },
--			-- Change the "hint" color to the "orange" color, and make the "error" color bright red
--			on_colors = function(colors)
--				colors.hint = colors.orange
--				colors.error = "#ff0000"
--			end
--		})
--		vim.cmd[[colorscheme tokyonight-storm]]
--	end
--}


-- nordic
--return {
--    'AlexvZyl/nordic.nvim',
--    lazy = false,
--    priority = 1000,
--    config = function()
--        require 'nordic' .load()
--    end
--}


--return {
--    'ellisonleao/gruvbox.nvim',
--    lazy = false,
--    priority = 1000,
--    config = function ()
--        require("gruvbox").setup({
--            terminal_colors = true, -- add neovim terminal colors
--            undercurl = true,
--            underline = true,
--            bold = true,
--            italic = {
--                strings = true,
--                emphasis = true,
--                comments = true,
--                operators = false,
--                folds = true,
--            },
--            strikethrough = true,
--            invert_selection = false,
--            invert_signs = false,
--            invert_tabline = false,
--            invert_intend_guides = false,
--            inverse = true, -- invert background for search, diffs, statuslines and errors
--            contrast = "", -- can be "hard", "soft" or empty string
--            palette_overrides = {},
--            overrides = {},
--            dim_inactive = false,
--            transparent_mode = false,
--        })
--        vim.cmd("colorscheme gruvbox")
--    end
--}

--return {
--    "nyoom-engineering/oxocarbon.nvim",
--    config = function ()
--        vim.opt.background = "dark" -- set this to dark or light
--        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--
--        vim.cmd.colorscheme "oxocarbon"
--    end
--}

return {
    "i3d/vim-jimbothemes",
    config = function ()
        vim.opt.background = "dark" -- set this to dark or light
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.cmd.colorscheme "breakingbad"
    end
}
