local on_attach = function(client, bufnr)
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  -- Enable format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
    })
  end
end

local servers = {
  bashls = {},
  clangd = {},
  csharp_ls = {},
  cssls = {},
  cssmodules_ls = {},
  efm = {},
  gopls = {},
  html = {},
  jsonls = {},
  rust_analyzer = {},
  sqlls = {},
  svelte = {},
  pyright = {},
  tsserver = {},
  volar = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

local lspconfig = require('lspconfig')
local util = require('lspconfig/util')

lspconfig.gdscript.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),

  on_attach = on_attach,

  flags = {
    debounce_text_changes = 150,
  }
}

lspconfig.efm.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },

  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      gdscript = {
        { formatCommand = "gdformat -l 80 -", formatStdin = true }
      },
    },
  }
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    languages = {
      python = {
        { formatCommand = 'blue', formatStdin = true }
      },
    },
  }
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
-- Setup nvim-lspconfig for Volar
local nvim_lsp = require('lspconfig')

nvim_lsp.volar.setup {}

-- Define a function to run eslint --fix on save
local function eslint_fix()
  vim.cmd([[
    augroup EslintFix
      autocmd!
      autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.vue silent! :EslintFixAll
    augroup END
  ]])
end

local function run_csharpier()
  local bufnr = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(bufnr)

  vim.loop.spawn("dotnet", {
    args = { "csharpier", filepath },
  }, function(code, signal)
    if code == 0 then
      vim.schedule(function()
        vim.api.nvim_command("checktime") -- Reload the buffer if it has been modified
      end)
    end
  end)
end

-- Create an autocmd to run CSharpier asynchronously on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.cs",
  callback = run_csharpier,
})
-- vim.api.nvim_command("autocmd BufWritePre *.cs execute ':silent !dotnet csharpier %'")
-- Register the eslint_fix function
eslint_fix()
-- lspconfig.rust_analyzer.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = {
--     'rustup', 'run', 'stable', 'rust-analyzer'
--   },
-- }
