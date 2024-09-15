return {

  {
    "neovim/nvim-lspconfig",
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      vim.keymap.set("n", "<leader>M", "<cmd>Mason<CR>")
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition")
          map("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration")
          map("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover")
          map("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Go to reference")
          map("gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help")
          map("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation")
          map("gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition")
          map("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
        end,
      })
    end,
  },

}
