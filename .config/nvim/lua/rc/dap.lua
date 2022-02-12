local dap = require "dap"

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { require("installer/integrations/da").get "node2" },
}
dap.configurations.typescript = {
  {
    type = "node2",
    request = "attach",
    name = "Attach node",
  },
}

vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>AerialToggle<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', "<leader>d", ":lua require'dapui'.toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader><leader>df", ":lua require'dapui'.eval()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<F5>", ":lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<F10>", ":lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<F11>", ":lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<F12>", ":lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>bc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n',"<leader>l", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { snoremap = true, ilent = true })

require("nvim-dap-virtual-text").setup()
require("dapui").setup()
