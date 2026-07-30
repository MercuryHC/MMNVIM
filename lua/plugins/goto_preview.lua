return {
  "rmagatti/goto-preview",
  opts = {
    -- 自定义浮窗大小和边框，可根据喜好调整[citation:6]
    width = 80,
    height = 12,
    border = {"⇱", "─", "╮", "│", "╯", "─", "╰", "│"},
    -- 设置为 true 可以使用插件自带的快捷键
    default_mappings = true,
    -- 打开时自动聚焦到浮窗
    focus_on_open = true
  },
  keys = { -- 可以自定义你习惯的快捷键，这里用 gpd 作为示例
  {
    "gpd",
    function()
      require("goto-preview").goto_preview_definition()
    end,
    desc = "Preview Definition"
  }, {
    "gpt",
    function()
      require("goto-preview").goto_preview_type_definition()
    end,
    desc = "Preview Type Definition"
  }, {
    "gpi",
    function()
      require("goto-preview").goto_preview_implementation()
    end,
    desc = "Preview Implementation"
  }, {
    "gpD",
    function()
      require("goto-preview").goto_preview_declaration()
    end,
    desc = "Preview Declaration"
  }, {
    "gP",
    function()
      require("goto-preview").close_all_win()
    end,
    desc = "Close All Preview Windows"
  },
  {
    "gp",
    function ()
      -- require("goto-preview").close_all_win()
    end,
    desc = "Goto Preview",
  },
  },
}
