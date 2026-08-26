return {
    "voldikss/vim-translator",
    config = function()
        -- ============ 基本设置 ============
        -- 默认目标语言：中文
        vim.g.translator_target_lang = 'zh'
        -- 默认源语言：自动检测
        vim.g.translator_source_lang = 'auto'
        -- 显示方式：浮动窗口
        vim.g.translator_window_type = 'popup'
        -- 浮动窗口最大宽度和高度
        vim.g.translator_popup_width = 60
        vim.g.translator_popup_height = 20

        -- ============ 快捷键映射 ============
        -- 普通模式下翻译光标下的单词（在底部命令行显示结果）
        vim.keymap.set('n', '<Leader>t', '<Plug>Translate', { silent = true, desc = 'Translate word' })

        -- 可视模式下翻译选中的文本（在底部命令行显示结果）
        vim.keymap.set('v', '<Leader>t', '<Plug>TranslateV', { silent = true, desc = 'Translate selection' })

        -- 普通模式下翻译光标下的单词（在浮动窗口显示结果）
        vim.keymap.set('n', '<Leader>T', '<Plug>TranslateW', { silent = true, desc = 'Translate word in popup' })

        -- 可视模式下翻译选中的文本（在浮动窗口显示结果）
        vim.keymap.set('v', '<Leader>T', '<Plug>TranslateWV', { silent = true, desc = 'Translate selection in popup' })

        -- 普通模式下翻译并替换光标下的单词（直接替换原文）
        vim.keymap.set('n', '<Leader>tr', '<Plug>TranslateR', { silent = true, desc = 'Translate and replace' })

        -- 可视模式下翻译并替换选中的文本（直接替换原文）
        vim.keymap.set('v', '<Leader>tr', '<Plug>TranslateRV', { silent = true, desc = 'Translate and replace selection' })

        -- 普通模式下弹出翻译输入框，输入要翻译的文本
        vim.keymap.set('n', '<Leader>ti', '<Plug>TranslateInput', { silent = true, desc = 'Translate input' })

        -- ============ 可选：翻译引擎切换（默认使用 Google） ============
        -- 可选值：'google', 'bing', 'youdao', 'deepl', 'baidu'
        -- vim.g.translator_default_engines = { 'google' }
    end
}