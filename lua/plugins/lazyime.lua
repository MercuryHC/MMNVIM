local is_mac = vim.loop.os_uname().sysname == "Darwin"

return {
  "StellarDeca/lazyime.nvim",
  cond = is_mac,
  lazy = true,
  opts = {},
  event = { "VeryLazy" },
}
