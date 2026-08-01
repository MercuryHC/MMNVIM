-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 添加自定义插件
local sysname = vim.loop.os_uname().sysname
if sysname == "Darwin" then
  vim.opt.runtimepath:append("$HOME/Workspaces/Code/nvim_plugins/example")

  local pkg = require("example")
  vim.print(pkg.info)
  pkg.setup()
end