local M = {}

local formatting_group = vim.api.nvim_create_augroup("lsp_formatting", { clear = true })
local highlight_group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })

-- Highlight symbol under cursor. The delay is configured via `vim.opt.updatetime`.
function M.enable_cursor_highlighting(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = highlight_group }
    vim.api.nvim_create_autocmd("CursorHold", {
        callback = vim.lsp.buf.document_highlight,
        buffer = bufnr,
        group = highlight_group,
        desc = "Document highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
        callback = vim.lsp.buf.clear_references,
        buffer = bufnr,
        group = highlight_group,
        desc = "Clear all the references",
    })
  end
end

function M.enable_auto_formatting(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = formatting_group, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = formatting_group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end

return M
