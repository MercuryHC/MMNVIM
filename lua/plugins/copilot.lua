return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local cmd = vim.fn.stdpath("data") .. "/mason/bin/copilot-language-server"

      if vim.fn.executable(cmd) ~= 1 then
        vim.notify(
          ("copilot-language-server not found at %s"):format(cmd),
          vim.log.levels.WARN
        )
        return
      end

      vim.lsp.config("copilot", {
        cmd = { cmd, "--stdio" },
      })

      vim.lsp.enable("copilot")
    end,
  },
}
