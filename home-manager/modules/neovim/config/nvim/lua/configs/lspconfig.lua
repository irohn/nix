local map = vim.keymap.set
local lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "gr", vim.lsp.buf.references, opts "Go to reference")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "K", vim.lsp.buf.hover, opts "Hover information")
  map("n", "<leader>d", vim.diagnostic.open_float, opts "Open diagnostics")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")

end

-- disable semanticTokens
local on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

lspconfig.nil_ls.setup {}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

lspconfig.pyright.setup {}

lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,

  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.helm_ls.setup {}
