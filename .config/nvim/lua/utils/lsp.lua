local M = {}

-- Highlight symbol under cursor. The delay is configured via `vim.opt.updatetime`.
function M.enable_cursor_highlighting(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = group }
    vim.api.nvim_create_autocmd("CursorHold", {
        callback = vim.lsp.buf.document_highlight,
        buffer = bufnr,
        group = group,
        desc = "Document highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
        callback = vim.lsp.buf.clear_references,
        buffer = bufnr,
        group = group,
        desc = "Clear all the references",
    })
  end
end

return M
