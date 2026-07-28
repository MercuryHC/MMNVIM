-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 创建 Markdown 自动化命令
-- 实现 Markdown 文件自动完成如下设置：
-- 1. 禁用拼写检查
-- 2. 禁用 LSP 诊断信息显示
-- 3. 执行 RenderMarkdown disable 命令，修复中文表格
vim.api.nvim_create_augroup("makrkdown_setting", {clear = true})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "makrdown",
  group = "makrkdown_setting",
  callback = function ()
    -- 1. 禁用拼写检查
    vim.opt_local.spell = false

    -- 2. 禁用 LSP 诊断信息显示
    -- 可以使用 tiny_inline_diagnostic 插件进行代替，隐藏具体的 diagnostic 信息
    -- vim.diagnostic.enable(false)

    -- 3. 执行 RenderMarkdown disable 命令
    vim.cmd("RenderMarkdown disable")
  end
})
