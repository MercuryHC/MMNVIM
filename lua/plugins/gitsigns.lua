return {
  "lewis6991/gitsigns.nvim",
  opts = {
    -- 开启当前行代码提交信息（blame）的显示
    current_line_blame = true,
    -- 可选：配置 blame 信息的显示样式，例如位置和延时
    current_line_blame_opts = {
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'  -- 显示位置
      delay = 100,           -- 延迟100ms后显示
    },
  },
}
