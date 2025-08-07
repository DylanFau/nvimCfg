local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>gr', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }) -- Oil
vim.keymap.set("n", "<leader>th", ":Themery<CR>", {	desc = "Open Themery" }) -- Open Themery

-- Grapple Maps
vim.keymap.set("n", "<leader>m", require("grapple").toggle)
vim.keymap.set("n", "<leader>M", require("grapple").toggle_tags)
vim.keymap.set("n", "<leader>1", "<cmd>Grapple select index=1<cr>")
vim.keymap.set("n", "<leader>2", "<cmd>Grapple select index=2<cr>")
vim.keymap.set("n", "<leader>3", "<cmd>Grapple select index=3<cr>")
vim.keymap.set("n", "<leader>4", "<cmd>Grapple select index=4<cr>")
vim.keymap.set("n", "<leader>5", "<cmd>Grapple select index=5<cr>")
vim.keymap.set("n", "<leader>6", "<cmd>Grapple select index=6<cr>")
vim.keymap.set("n", "<leader>7", "<cmd>Grapple select index=7<cr>")

-- Rebinds escape key
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")

vim.keymap.set("n", "<leader>tr", function()
	vim.cmd[[hi Normal guibg=NONE ctermbg=NONE]]
	vim.cmd[[hi NormalNC guibg=NONE ctermbg=NONE]]
	vim.cmd[[hi NormalFloat guibg=NONE ctermbg=NONE]]
	vim.cmd[[hi Pmenu guibg=NONE ctermbg=NONE]] -- for popup menus
end)

-- Closes the terminal
vim.api.nvim_set_keymap('t', '<C-x>', [[<C-\><C-n>:q!<CR>]], { noremap = true, silent = true })

-- Opens web files in safari/browser --> Not working/Fix this
vim.keymap.set("n", "<leader>x", "<leader>gx", { desc = "Open URL under cursor" })

-- Open config from anywhere
vim.keymap.set('n', '<leader>oc', function()
	require('oil').open('~/.config/nvim')
end)

vim.keymap.set('n', '<leader>woc', function()
	require('oil').open('~/AppData/Local/nvim')
end)

-- Everything below for starting and stopping dev server
local dev_server = {
  job_id = nil
}

-- Start the server
function dev_server.start()
  if dev_server.job_id then
    print("🚫 Dev server already running (job ID: " .. dev_server.job_id .. ")")
    return
  end

  local cmd = "npm run dev"
  dev_server.job_id = vim.fn.jobstart(cmd, {
    cwd = vim.fn.getcwd(),
    detach = true,
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.schedule(function()
          vim.notify(table.concat(data, "\n"), vim.log.levels.INFO, { title = "Dev Server" })
        end)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.schedule(function()
          vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR, { title = "Dev Server Error" })
        end)
      end
    end,
    on_exit = function(_, code)
      vim.schedule(function()
        vim.notify("Dev server exited with code " .. code, vim.log.levels.INFO)
        dev_server.job_id = nil
      end)
    end
  })

  print("✅ Dev server started (job ID: " .. dev_server.job_id .. ")")
end

-- Stop the server
function dev_server.stop()
  if not dev_server.job_id then
    print("🚫 Dev server not running.")
    return
  end

  vim.fn.jobstop(dev_server.job_id)
  print("🛑 Dev server stopped.")
  dev_server.job_id = nil
end

-- Restart the server
function dev_server.restart()
  dev_server.stop()
  vim.defer_fn(dev_server.start, 500)  -- wait 500ms before restarting
end

-- Create command
vim.api.nvim_create_user_command("Dev", function(opts)
  local action = opts.args
  if action == "start" then
    dev_server.start()
  elseif action == "stop" then
    dev_server.stop()
  elseif action == "restart" then
    dev_server.restart()
  else
    print("Unknown command:", action)
  end
end, {
  nargs = 1,
  complete = function(arglead, _, _)
    return vim.tbl_filter(function(cmd)
      return vim.startswith(cmd, arglead)
    end, { "start", "stop", "restart" })
  end
})


-- Diagnostic Popup
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

