-- Define the custom file type associations
vim.filetype.add {
  extension = {
    -- Example: Associate .xyz files with the xyz file type
    mac = 'maxima',
  },
}

-- For a specific file type, e.g., JavaScript
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'maxima',
  callback = function()
    vim.bo.commentstring = '/* %s */'
  end,
})

-- Function to run custom script with current buffer and current working directory as arguments
local function maxima_debug()
  -- Get the name of the current buffer (full file path)
  local bufname = vim.api.nvim_buf_get_name(0)
  -- Get the current working directory
  local cwd = vim.fn.getcwd()
  -- Define the command to run your script with the buffer name and current working directory as arguments
  -- Make sure the script is executable: chmod +x path/to/your_script.sh
  local command = string.format("/home/sean/.scripts/nvim/maxima_debug_session.sh '%s' '%s'", cwd, bufname)
  -- Execute the command
  -- vim.api.nvim_command('! ' .. command)
  vim.fn.jobstart(command, { detatch = true })
end

-- Create a custom command to trigger the function
vim.api.nvim_create_user_command('RunScript', maxima_debug, {})

-- Optional: Bind the command to a key mapping for easier access
vim.api.nvim_set_keymap('n', '<leader>5', ':RunScript<CR>', { noremap = true, silent = true })
