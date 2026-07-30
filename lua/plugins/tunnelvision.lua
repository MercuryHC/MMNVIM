return {
  "leolaurindo/tunnelvision.nvim",
  opts = {
    scope = "function", -- 作用域限定在函数内
    source = { "treesitter", "word" }, -- 优先使用 Tree-sitter
    mode = "dynamic", -- 光标移动时自动更新目标
  },
  keys = {
    { "<leader>uv", ":TunnelVision toggle<CR>", desc = "Toggle TunnelVision" },
  },
}
