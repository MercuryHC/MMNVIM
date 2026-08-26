-- In ~/.config/nvim/lua/plugins/voidlight.lua
-- =============================================================================
-- Voidlight 主题配置（仿明基编程模式：纯黑 + 暖橙护眼）
-- =============================================================================
return {
  -- 1. 注册 Voidlight 主题插件
  {
    "christerso/voidlight-lazyvim-theme",
    name = "voidlight",
    lazy = false,
    priority = 1000,
    config = function()
      require("voidlight").setup({
        colors = {
          -- 想换口味可以调这里：
          -- accent = "#ff6b35",   -- 偏红的暖橙
          accent = "#e6b450",   -- 偏黄的琥珀
          -- bg = "#0a0a0a",       -- 如果嫌纯黑太硬，可以换这个
        },
      })
      vim.cmd.colorscheme("voidlight")
    end,
  },

  -- 2. 告诉 LazyVim 用 Voidlight 作为默认主题
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "voidlight",
    },
  },
}