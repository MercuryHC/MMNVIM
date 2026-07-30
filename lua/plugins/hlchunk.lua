return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true, -- 启动代码块高亮功能
        -- 还可以在这里自定义高亮样式
      },
    })
  end,
}
