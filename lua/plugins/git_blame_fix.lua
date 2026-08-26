-- =============================================================================
-- Git Blame 颜色修复
-- =============================================================================
-- Voidlight 是纯黑背景，自带的灰色 blame 文字直接糊在黑底上看不清
-- 这里把 blame 相关的所有高亮组重新调一遍，用偏暗的灰做虚拟文字
-- 让它"刚好能看见"，不抢主代码的视觉重心
--
-- 覆盖的插件：
--   - gitsigns.nvim (GitSignsCurrentLineBlame*)
--   - vim-fugitive (fugitiveblame, Blame*)
--   - git-messenger / vim-gitgutter (兼容性)
-- =============================================================================

-- 调到刚刚好能看见的程度，不会跟主代码抢视觉重心
local blame_fg = "#585e66"      -- 主文字（比原主题的 fg3 略亮一丢丢）
local blame_fg_dim = "#424850"  -- 次要信息（刻意压暗，不打扰阅读）
local blame_accent = "#825a14"  -- commit hash 暖橙（也降饱和度，更柔和）

return {
  {
    "LazyVim/LazyVim",
    -- 在 colorscheme 加载完成后，再覆盖这些高亮
    opts = function(_, opts)
      -- 保留原始 colorscheme 设置
      local original_colorscheme = opts.colorscheme

      -- 注册一个 ColorScheme 自动命令，主题加载完后再应用我们的覆盖
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local hl = vim.api.nvim_set_hl

          -- gitsigns.nvim 的当前行 blame（最常见）
          hl(0, "GitSignsCurrentLineBlame", {
            fg = blame_fg,
            bold = false,
            italic = false, -- 不用斜体，避免在小字号下糊掉
          })
          hl(0, "GitSignsCurrentLineBlameNr", {
            fg = blame_accent,
            bold = false, -- 取消加粗，跟整体保持低调
          })
          hl(0, "GitSignsCurrentLineBlameCoords", {
            fg = blame_fg_dim,
          })

          -- gitsigns 的其他相关虚拟文本
          hl(0, "GitSignsAddPreview", { fg = blame_fg })
          hl(0, "GitSignsDeletePreview", { fg = blame_fg })

          -- vim-fugitive 的 :Gblame 窗口
          hl(0, "fugitiveblame", { fg = blame_fg })
          hl(0, "Blame", { fg = blame_fg })
          hl(0, "BlameCommitHash", { fg = blame_accent })
          hl(0, "BlameAuthor", { fg = blame_fg })
          hl(0, "BlameDate", { fg = blame_fg_dim })
          hl(0, "BlameFilename", { fg = blame_fg_dim })

          -- 兜底：有些插件会查 Comment 配色作为虚拟文本
          -- 这里不覆盖 Comment，避免影响代码注释
          -- 如果你的代码注释也被调暗，告诉我，我再加兜底
        end,
      })

      return opts
    end,
  },
}