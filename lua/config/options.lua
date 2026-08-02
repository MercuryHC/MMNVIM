-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- NOTE: use ":help option-list" to get vim.opt.xxx config

local g = vim.g
local opt = vim.opt

-- ** 光标与行号
opt.cursorline = true -- 高亮当前行
opt.cursorcolumn = false -- 高亮当前列
opt.number = true -- 显示行号
opt.relativenumber = true -- 显示相对行号
-- opt.colorcolumn = "120" -- 120列标记
local win_height = vim.fn.winheight(0) -- 智能设置光标上下保持行号
opt.scrolloff = math.floor((win_height - 1) / 5)
opt.sidescrolloff = math.floor((win_height - 1) / 5)

-- 智能换行
opt.wrap = true --启用自动换行
opt.breakindent = true -- 启用断行缩进
opt.linebreak = true --启用行内断行(在单词边界换行)

-- lsp

-- 获取系统类型
-- 若是macOS，配置个人设置
-- 若是Linux，配置工作设置
-- 示例为AutoFormat
local sysname = vim.loop.os_uname().sysname
if sysname == "Darwin" then
  -- macOS: 个人设置
  g.autoformat = true -- 启用自动格式化
elseif sysname == "Linux" then
  -- Linux: 工作设置
  g.autoformat = false -- 关闭自动格式化
end

-- clipboard
-- ============================================================
-- 本地（macOS）：直接用 pbcopy/pbpaste，读写都正常
-- 远程（SSH）：  走 OSC52，终端支持即可双向复制
-- ============================================================
vim.opt.clipboard = "unnamedplus"

if vim.env.SSH_CONNECTION then
  -- SSH 远程：使用 OSC52（写由终端消费；读依赖终端支持 OSC52 paste）
  local function osc52_copy(text)
    local encoded = vim.fn.system({ "base64" }, text):gsub("\n", "")
    io.write(string.format("\x1b]52;c;%s\x1b\\", encoded))
    io.flush()
    return true
  end
  vim.g.clipboard = {
    name = "osc52_custom",
    copy = {
      ["+"] = function(lines) return osc52_copy(table.concat(lines, "\n")) end,
      ["*"] = function(lines) return osc52_copy(table.concat(lines, "\n")) end,
    },
    paste = {
      ["+"] = function() return {} end,
      ["*"] = function() return {} end,
    },
  }
else
  -- 本地：清空自定义 provider，让 nvim 自动选用 pbcopy/pbpaste
  vim.g.clipboard = nil
end