-- Copyright (c) 2026 MercuryHC. All Rights Reserved.
-- 插件入口

local M = {} -- 局部变量M

M.info = "Hello, my first nvim plugin!"

function M.setup()
	vim.notify("Setup Runnnnnn........")
end

return M

-- return {
--   info = "Hello, my first nvim plugin!"
-- }
