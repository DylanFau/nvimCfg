vim.opt.signcolumn = 'yes'

local lspconfig_defaults = require('lspconfig').util.default_config
local capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

local cmp = require('cmp')
local npairs = require("nvim-autopairs")

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
	},
	mapping = { -- Disabled these mapping as Blink.cmp handles this behavior with different mappings, also conflicted with neotab
		-- ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- Next completion
		-- ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- Previous completion
		-- ['<Enter>'] = cmp.mapping.confirm({ select = true }), -- Confirm completion with Enter
		-- ['<C-Space>'] = cmp.mapping.complete(),                                   -- Trigger completion manually
	},
})

local on_attach = function(client, bufnr)
  -- Enable LSP-based keybindings
  local opts = { noremap = true, silent = true }

  -- Helper function for keymaps
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Set some example keymaps
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  print("LSP attached to buffer " .. bufnr)
end


local servers = {"lua_ls", "html", "ts_ls", "cssls", "jedi_language_server", "clangd"}

-- Makes sure all the servers are installed on launch
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = servers,
})

for _, server in ipairs(servers) do
	require("lspconfig")[server].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
