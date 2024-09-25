return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				-- para ruby, despues de agregar esto, vamos a :Mason e instalamos el linter y formatter
				--        null_ls.builtins.formatting.rubocop, --linting
				--        null_ls.builtins.diagnostics.rubocop, -- formatting
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.cppcheck,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.asmfmt
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
