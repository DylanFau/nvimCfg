local themes = { "github_dark", "github_dark_dimmed", "Nightfox", "Dayfox", "Duskfox", "Nordfox", "Terafox", "Carbonfox", "tokyonight", "tokyonight-night	", "tokyonight-storm", "tokyonight-day", "tokyonight-moon"}

return {
	{ "EdenEast/nightfox.nvim" },
	{ "projekt0n/github-nvim-theme" },
	{
		"folke/tokyonight.nvim",
	},
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = themes,
				livePreview = true,
			})
		end
	},
}
