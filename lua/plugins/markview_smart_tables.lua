-- =============================================================================
-- markview.nvim + markview-smart-tables.nvim 完整配置
-- 目标: 替代 render-markdown.nvim,实现 markdown 表格自动换行/收缩渲染
-- 行为:
--   - Normal/Visual 模式: 保持 smart-tables 渲染(漂亮的宽表)
--   - Insert/Replace 模式: 自动回退到原始 markdown(可编辑、光标可见)
--   - 光标位置/buffer 内容不会被改动,只是 unconceal 源行
-- 适用于 lazy.nvim,直接 return 给 setup 即可
-- =============================================================================

return {
  -- ---------------------------------------------------------------------------
  -- 1) 主渲染器: markview.nvim
  --    替换 render-markdown.nvim (LazyVim 用户需在 disabled_plugins 里去掉它)
  -- ---------------------------------------------------------------------------
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- 不推荐 lazy-load,会丢首次打开的渲染
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      local presets = require("markview.presets")

      return {
        -- ★ 关键: 把 markview 的表格渲染钩到 smart-tables
        renderers = {
          markdown_table = function(buffer, item)
            require("markview-smart-tables").render(buffer, item)
          end,
        },

        -- ====================================================================
        -- 渲染 vs Hybrid mode 的两个独立开关
        -- --------------------------------------------------------------------
        -- modes        : 在这些模式下 markview 整体预览开启
        --                (空 = 全部关闭;不配 = 默认 {n, no, c})
        -- hybrid_modes : 在预览开启的前提下,这些模式会"回退"到原始 markdown
        --                (空 = 永不回退,光标在表格里看不见)
        -- ====================================================================

        -- Normal / Visual 时保持渲染,Insert/Replace 时回退到原始
        modes = { "n", "no", "v", "V", "x" },

        preview = {
          -- ★ 只在 insert 系模式回退到原始 markdown
          -- "i"   = insert
          -- "ic"  = insert + cmdline autocomplete
          -- "ix"  = insert + execute mapping
          -- "R"/"Rc"/"Rv"/"Rx" = replace 系 (virtual replace / replace 模式)
          hybrid_modes = { "i", "ic", "ix", "R", "Rc", "Rv", "Rx" },

          callbacks = {
            -- 进入 markdown 缓冲区时调一次:让光标在 conceal 行也可见
            on_enable = function(_, win)
              -- level=2 启用基于字符的 conceal
              vim.wo[win].conceallevel = 2
              -- "nvic" = n/v/i/c 模式都把光标显示在 conceal 文本上
              -- (smart-tables 用 conceal_lines 隐藏源行,这步很关键,
              --  否则 normal 模式下停在表格上光标会"消失")
              vim.wo[win].concealcursor = "nvic"
            end,
          },
        },

        -- 表格相关 (smart-tables 没接管时的兜底配置,正常情况下用不到)
        markdown = {
          tables = {
            preset = presets.tables.rounded, -- ╭─╮ 风格的圆角边框
            -- use_virt_lines = false,         -- virt_lines 在某些场景会跳光标
          },
        },
      }
    end,
  },

  -- ---------------------------------------------------------------------------
  -- 2) 表格智能换行扩展
  --    - wrap_width:   表格最大占窗口宽度的比例 (0~1)
  --    - wrap_minwidth: 列被压到多窄才开始硬断单词
  -- ---------------------------------------------------------------------------
  {
    "gunasekar/markview-smart-tables.nvim",
    dependencies = { "OXY2DEV/markview.nvim" },
    event = "VeryLazy", -- 跟随 markview 即可,不需要更早
    opts = {
      wrap_width = 0.9,    -- 推荐 0.85~0.95,留点边距更舒服
      wrap_minwidth = 5,   -- 单列最低宽度,再低就硬断单词
    },
  },
}

-- =============================================================================
-- 如果你之前在用 render-markdown,需要禁用它,避免冲突
-- -----------------------------------------------------------------------------
-- LazyVim 用户,在 lazyvim.config 中加:
--   opts = { disabled_plugins = { "render-markdown.nvim" } }
--
-- 纯 lazy.nvim 用户,直接从 spec 里删掉 render-markdown 即可
-- =============================================================================

-- =============================================================================
-- 推荐 keymap (按需加到你的 keymaps.lua)
-- -----------------------------------------------------------------------------
-- -- 总开关
-- vim.keymap.set("n", "<leader>mt", "<cmd>Markview toggle<CR>",
--   { desc = "Markview 预览开关" })
--
-- -- 临时在当前 buffer 强制显示原始 markdown (无视模式)
-- vim.keymap.set("n", "<leader>mr", "<cmd>Markview hybridToggle<CR>",
--   { desc = "Markview hybrid mode 切换" })
--
-- -- 切到 split 预览窗
-- vim.keymap.set("n", "<leader>mp", "<cmd>Markview splitToggle<CR>",
--   { desc = "Markview split 预览" })
--
-- -- linewise hybrid: 进出表格边界前几行也显示原始,避免越界看不清
-- vim.keymap.set("n", "<leader>ml", "<cmd>Markview linewiseToggle<CR>",
--   { desc = "Markview linewise hybrid" })
-- =============================================================================

-- =============================================================================
-- 行为速查
-- -----------------------------------------------------------------------------
-- 模式          | 看到的画面              | 光标在表格里
-- --------------|-------------------------|----------------
-- normal        | smart-tables 渲染后的表 | 隐藏(用 j/k 移动)
-- visual        | 同上                    | 可见
-- insert        | 原始 markdown           | 可见,直接编辑
-- replace (R)   | 原始 markdown           | 可见,直接编辑
-- command (c)   | 渲染                    | 隐藏
-- =============================================================================

-- =============================================================================
-- 安装后验证
-- -----------------------------------------------------------------------------
-- :checkhealth markview-smart-tables
--   检查项: Neovim 版本 ≥ 0.11、markview 已装、renderers 钩子已挂载
-- :checkhealth markview
--   检查项: treesitter markdown / markdown_inline 解析器
-- =============================================================================
