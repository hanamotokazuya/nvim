local M = {
	"MeanderingProgrammer/markdown.nvim",
	event = "VeryLazy",
}

function M.config()
	require("render-markdown").setup({})
end

return M
