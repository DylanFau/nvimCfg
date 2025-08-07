vim.wo.relativenumber = true
vim.opt.clipboard = "unnamedplus"

syntax = enable

-- Require any extra plugins and files.
require("configs.lazy")
require "mappings"
require("oil").setup()
require("neotab").setup()

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.keymap.set('n', "<space>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 12)
end)

vim.cmd[[hi Normal guibg=NONE ctermbg=NONE]]
vim.cmd[[hi NormalNC guibg=NONE ctermbg=NONE]]
vim.cmd[[hi NormalFloat guibg=NONE ctermbg=NONE]]
vim.cmd[[hi Pmenu guibg=NONE ctermbg=NONE]] -- for popup menus

