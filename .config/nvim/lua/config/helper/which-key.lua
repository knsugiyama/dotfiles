local wk = safe_require('which-key')

if not wk then
  return
end

local opts = {
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}

wk.setup(config)
