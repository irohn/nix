return {

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  { -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },

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
