-- LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
    require("which-key").add({
    name = "lsp",
    { "gD",        "<cmd>lua vim.lsp.buf.declaration()<CR>",                                desc = "Jumps to the declaration of the symbol under the cursor" },
    { "gd",        "<cmd>lua vim.lsp.buf.definition()<CR>",                                 desc = "Jumps to the definition of the symbol under the cursor" },
    { "K",         "<cmd>lua vim.lsp.buf.hover()<CR>",                                      desc = "Displays hover information about the symbol under the cursor in a floating window" },
    { "gi",        "<cmd>lua vim.lsp.buf.implementation()<CR>",                             desc = "Lists all the implementations for the symbol under the cursor in the quickfix window" },
    { "<C-k>",     "<cmd>lua vim.lsp.buf.signature_help()<CR>",                             desc = "Displays signature information about the symbol under the cursor in a floating window" },
    { "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",                       desc = "Add the folder at path to the workspace folders" },
    { "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",                    desc = "Remove the folder at path from the workspace folders" },
    { "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", desc = "List workspace folders" },
    { "<leader>D",  "<cmd>lua vim.lsp.buf.type_definition()<CR>",                            desc = "Jumps to the definition of the type of the symbol under the cursor" },
    { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>",                                     desc = "Rename old_fname to new_fname" },
    { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",                                desc = "Selects a code action available at the current cursor position" },
    { "gr",        "<cmd>lua vim.lsp.buf.references()<CR>",                                 desc = "Lists all the references to the symbol under the cursor in the quickfix window" },
    { "<leader>f",  "<cmd>lua vim.lsp.buf.formatting()<CR>",                                 desc = "Formats the current buffer" },
  }, {
    buffer = 0,
  })
})
