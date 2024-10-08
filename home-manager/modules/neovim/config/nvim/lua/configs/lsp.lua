require("mason").setup({
  ui = {
    icons = {
      package_installed = " ",
      package_pending = " ",
      package_uninstalled = " "
    }
  }
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
  },
})

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,

  -- Dedicated handlers --

  -- Lua
  ["lua_ls"] = function ()
    require("lspconfig").lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
            disable = { 'missing-fields' }
          },
          workspace = {
            library = {
              vim.env.VIMRUNTIME,
              "${3rd}/luv/library",
            },
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        }
      }
    }
  end,

  -- Python
  ["pyright"] = function ()
    require("lspconfig").pyright.setup {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace"
          }
        }
      }
    }
  end,

  -- YAML
  ["yamlls"] = function ()
    require("lspconfig").yamlls.setup {
      settings = {
        yaml = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
            ["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
            ["https://json.schemastore.org/ansible-playbook.json"] = "*play*.{yml,yaml}",
            ["https://json.schemastore.org/ansible-stable-2.9.json"] = "roles/tasks/*.{yml,yaml}",
            ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
            ["https://json.schemastore.org/gitlab-ci.json"] = "*gitlab-ci*.{yml,yaml}",
            ["https://json.schemastore.org/azure-pipelines.json"] = "azure-pipelines.{yml,yaml}",
            ["https://json.schemastore.org/helmfile.json"] = "helmfile.{yml,yaml}",
            ["https://json.schemastore.org/helm-chart.json"] = "Chart.{yml,yaml}",
            ["https://json.schemastore.org/package.json"] = "package.{yml,yaml}",
          },
        },
      }
    }
  end,
}
