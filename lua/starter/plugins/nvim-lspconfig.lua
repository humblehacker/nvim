return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      opts.desc = "Show line diagnostics"
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

      opts.desc = "Show documentation for what is under cursor"
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Go to declaration"
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

      opts.desc = "Go to definition"
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

      opts.desc = "Go to implementation"
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

      opts.desc = "Show signature"
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

      -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      -- vim.keymap.set('n', '<space>wl', function()
      --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      -- end, opts)
      -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      -- vim.keymap.set('n', '<space>f', function()
      --   vim.lsp.buf.format { async = true }
      -- end, opts)
    end

    lspconfig["sourcekit"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = {
        "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
      },
      root_dir = function(filename, _)
        return util.root_pattern("buildServer.json")(filename)
          or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
          or util.find_git_ancestor(filename)
          or util.root_pattern("Package.swift")(filename)
      end,
    })
  end,
}
