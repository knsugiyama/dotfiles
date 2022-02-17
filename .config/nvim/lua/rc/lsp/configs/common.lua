local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = { noremap=true, silent=true }

return {
  on_attach = function(client, bufnr)
    require("lsp_signature").on_attach()
    require("aerial").on_attach(client, bufnr)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'C-n', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'C-p', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
    
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>CodeActionMenu<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

    vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync({}, 7000)
      augroup END
    ]])
  end,
  capabilities = capabilities,
}
