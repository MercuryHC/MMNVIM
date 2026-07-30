-- 增强括号匹配
-- 匹配if else等标签，使用 % 进行跳转
-- 显示另外一个括号外溢行号
return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "andymass/vim-matchup" -- 增强的括号匹配插件
    },
    opts = function(_, opts)
      -- 启用 matchup 扩展
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "matchup")
      return opts
    end,
  },
  -- 配置 vim-matchup 本身
  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = {
        mothod = "popup"
      }                                        -- 屏幕外显示方式
      vim.g.matchup_matchparen_deferred = true -- 延迟显示，更流畅
    end,
  },
}
