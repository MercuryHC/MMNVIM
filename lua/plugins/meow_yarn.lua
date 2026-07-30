-- 直观的 LSP 层次结构可视化插件，专为 C++ 等语言设计，可以清晰地展示类的继承关系（父类/子类）以及函数的调用关系

-- 查看类继承关系：
-- 将光标放在 C++ 类的名字上（如 class MyClass 中的 MyClass）
-- 按 <leader>ys 查看父类链
-- 按 <leader>yt 查看子类列表

-- 查看函数调用关系：
-- 将光标放在函数名上
-- 按 <leader>yc 查看谁调用了这个函数
-- 按 <leader>yC 查看这个函数调用了谁

-- 在树中导航：
-- 用方向键或 j/k 上下移动
-- 按 o 展开/折叠节点
-- 按 Enter 跳转到该符号的定义位置

return {
  "retran/meow.yarn.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",  -- 必需的 UI 依赖
  },
  config = function()
    -- 1. 插件的基本配置
    local meow_yarn = require("meow.yarn")
    meow_yarn.setup({
      -- 窗口样式配置
      window = {
        width = 0.6,    -- 窗口宽度（相对比例）
        height = 0.6,   -- 窗口高度（相对比例）
        border = "rounded",   -- 边框样式: "rounded", "single", "double", "none"
        preview_height_ratio = 0.5,
        -- "vertical": tree above, preview below(default)
        -- "horizontal": tree left, preview right
        layout = "vertical",
      },
      -- 配置默认显示的层级深度
      expand_level = 1,   -- 默认展开到第几层（1=只显示根节点）
    })

    -- 2. 快捷键配置
    -- 类型层次（Type Hierarchy）
    vim.keymap.set("n", "<leader>ys", function()
      meow_yarn.open_tree("type_hierarchy", "supertypes")
    end, { desc = "[Y]arn: 查看父类（Super）" })

    vim.keymap.set("n", "<leader>yt", function()
      meow_yarn.open_tree("type_hierarchy", "subtypes")
    end, { desc = "[Y]arn: 查看子类（Sub）" })

    -- 调用层次（Call Hierarchy）
    vim.keymap.set("n", "<leader>yc", function()
      meow_yarn.open_tree("call_hierarchy", "callers")
    end, { desc = "[Y]arn: 查看调用者（Callers）" })

    vim.keymap.set("n", "<leader>yC", function()
      meow_yarn.open_tree("call_hierarchy", "callees")
    end, { desc = "[Y]arn: 查看被调用者（Callees）" })

    -- 可选：通用切换/重新加载当前视图
    vim.keymap.set("n", "<leader>yr", function()
      meow_yarn.refresh_tree()
    end, { desc = "[Y]arn: 刷新当前树" })

    vim.keymap.set("n", "<leader>yq", function()
      meow_yarn.close_tree()
    end, { desc = "[Y]arn: 关闭树窗口" })

    -- 3. 在弹出窗口中的快捷键（可选）
    -- 这些在打开树窗口后自动生效
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "meow-yarn",
      callback = function()
        -- 在树窗口中按 q 关闭，按 Enter 跳转
        vim.keymap.set("n", "q", "<cmd>MeowYarn close<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "<CR>", function()
          meow_yarn.jump_to_item()
        end, { buffer = true, silent = true })
        -- 在树中展开/折叠节点
        vim.keymap.set("n", "o", function()
          meow_yarn.toggle_node()
        end, { buffer = true, silent = true })
      end,
    })
  end,
}

