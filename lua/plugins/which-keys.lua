-- Which-keys 强化快捷键插件
-- 用来配置快捷键显示
-- 配置冲突快捷键延迟处理
-- 如: 按下`gd`用来跳转到函数定义，但是延迟获取`gdd`,用来显示goto-preview函数定义，解决快捷键冲突问题
-- `gd`跳转函数定义，`gdd`悬浮显示函数定义

return {
  "folke/which-key.nvim",
  opts = {
    -- 配置 g 作为前缀键
    spce = {
      { "g", group = "Goto" },
      {
        "gd",
        function()
          vim.lsp.buf.definition()
        end,
        desc = "Goto Definition"
      },
      {
        "gdd",
        function()
          local ok, gp = pcall(require, "goto-preview")
          if ok then
            gp.goto_preview_definition()
          else
            vim.lsp.buf.definition()
          end
        end,
        desc = "Preview Definition",
      },
      {
        "gdr",
        function()
          local ok, gp = pcall(require, "goto-preview")
          if ok and gp.goto_preview_refernece then
            gp.goto_preview_refernece()
          end
        end,
        desc = "Preview Reference",
      },
      {
        "gi",
        function()
          vim.lsp.buf.implementation()
        end,
        desc = "Goto Implementation"
      },
      {
        "gii",
        function()
          local ok, gp = pcall(require, "goto-preview")
          if ok then
            gp.goto_preview_implementation()
          end
        end,
        desc = "Preview Implementation"
      },
    },
  },
}
