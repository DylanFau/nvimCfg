return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			require "configs.lspconfig"
		end
	},
	{ "nvim-telescope/telescope.nvim",  dependencies = { "nvim-lua/plenary.nvim" } },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig" },
	{ "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "svelte" }} },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "cbochs/grapple.nvim" },
	{
		"kawre/neotab.nvim",
		event = "InsertEnter",
		opts = {},
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
	},
	{ "jmbuhr/otter.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim" },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end
	},
	{
		'saghen/blink.cmp',
		-- optional: provides snippets for the snippet source
		dependencies = 'rafamadriz/friendly-snippets',

		version = '*',
		opts = {
			keymap = { preset = 'default' },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},

			sources = { default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
		},
		opts_extend = { "sources.default" }
	}
}
