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
-- OSC52 剪贴板配置（适用于所有 Neovim 版本）
-- ============================================================

-- 检查是否已有 clipboard 配置，如果没有则创建
if not vim.g.clipboard then
    vim.g.clipboard = {}
end

-- 手动实现 OSC52 复制
local function osc52_copy(text)
    -- 使用 base64 编码
    local encoded = vim.fn.system({ "base64", "-w", "0" }, text):gsub("\n", "")
    -- 发送 OSC52 序列到终端
    io.write(string.format("\x1b]52;c;%s\x1b\\", encoded))
    io.flush()
    -- 返回 true 表示复制成功
    return true
end

-- 配置剪贴板
vim.g.clipboard = {
    name = "osc52_custom",
    copy = {
        ["+"] = function(lines)
            return osc52_copy(table.concat(lines, "\n"))
        end,
        ["*"] = function(lines)
            return osc52_copy(table.concat(lines, "\n"))
        end,
    },
    paste = {
        ["+"] = function()
            -- OSC52 不支持从系统剪贴板读取，返回空
            return {}
        end,
        ["*"] = function()
            return {}
        end,
    },
}

-- 启用系统剪贴板
vim.opt.clipboard = "unnamedplus"

-- 可选：复制时显示提示信息
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
            vim.notify("Copied to system clipboard via OSC52", vim.log.levels.INFO, { title = "Clipboard" })
        end
    end,
})