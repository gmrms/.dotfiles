-- Lvim
lvim.plugins = {
  { "github/copilot.vim" },
  { "catppuccin/nvim" }
}

lvim.colorscheme = "catppuccin-macchiato"

-- Vim
vim.opt.relativenumber = true

vim.g.copilot_assume_mapped = true

-- Dap
local dap = require("dap")

-- Kotlin
dap.adapters.kotlin = {
  type = "executable",
  command = "/home/gmrm/.local/share/lvim/mason/packages/kotlin-debug-adapter/adapter/bin/kotlin-debug-adapter",
  args = { "" }
}

dap.configurations.kotlin = {
  {
    type = "kotlin",
    request = "attach",
    projectRoot = "${workspaceFolder}",
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
    timeout = 5000
  }
}
