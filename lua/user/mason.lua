local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
}

function M.config()
	local servers = {
		"lua_ls",
		"ts_ls",
		"rust_analyzer",
		"gopls",
		"pyright",
		"cssls",
		"html",
		"yamlls",
		"bashls",
		"jsonls",
		"tailwindcss",
	}

	require("mason").setup({
		ui = {
			border = "rounded",
		},
	})

	require("mason-lspconfig").setup({
		ensure_installed = servers,
	})
end

return M
