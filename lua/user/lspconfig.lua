local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"folke/neodev.nvim",
		},
	},
}

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)

	if client.supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

function M.common_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	return capabilities
end

M.toggle_inlay_hints = function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
end

function M.config()
	local wk = require("which-key")
	wk.add({
		{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
		{ "<leader>lh", "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>", desc = "Hints" },
		{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
		{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
		{ "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
		{ "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
		{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
		{ "<leader>laa", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", mode = "v" },
	})

	local lspconfig = require("lspconfig")
	local icons = require("user.icons")

	local servers = {
		"lua_ls",
		"cssls",
		"html",
		"eslint",
		"pyright",
		"bashls",
		"jsonls",
		"yamlls",
		"rust_analyzer",
		"tailwindcss",
		"gopls",
	}

	local default_diagnostic_config = {
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
			},
		},
		virtual_text = false,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	local diagnostic_config = vim.diagnostic.config()
	if diagnostic_config then
		local signs = vim.tbl_get(diagnostic_config, "signs", "values")
		if signs then
			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
			end
		end
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	require("lspconfig.ui.windows").default_options.border = "rounded"

	for _, server in pairs(servers) do
		local opts = {
			on_attach = M.on_attach,
			capabilities = M.common_capabilities(),
		}

		local require_ok, settings = pcall(require, "user.lspsettings." .. server)
		if require_ok then
			opts = vim.tbl_deep_extend("force", settings, opts)
		end

		if server == "lua_ls" then
			require("neodev").setup({})
		end

		lspconfig[server].setup(opts)
	end

	-- ts_ls
	local function patch(result)
		if not vim.islist(result) or type(result) ~= "table" then
			return result
		end

		return { result[1] }
	end
	lspconfig.ts_ls.setup({
		handlers = {
			["textDocument/definition"] = function(err, result, method, ...)
				vim.lsp.handlers["textDocument/definition"](err, patch(result), method, ...)
			end,
		},
	})
end

return M
