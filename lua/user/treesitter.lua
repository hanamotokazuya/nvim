local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "lua",
      "c",
      "rust",
      "javascript",
      "typescript",
      "tsx",
      "css",
      "python",
      "bash",
      "markdown",
      "markdown_inline",
      "json",
      "toml",
      "html",
      "vim",
      "dockerfile",

    },
    highlight = { enable = true },
    indent = { enable = true },
  }
end

return M

