# This is only for my specific group theoretical outputs

vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  callback = function()
    vim.api.nvim_create_user_command("QSearch", function(opts)
      local input = opts.args

      local out = {}
      local i = 1
      while i <= #input do
        local c = input:sub(i,i)
        if c:match("%a") then
          -- normal generator letter
          table.insert(out, c)
        elseif c == "-" then
          -- make previous letter inverse
          out[#out] = out[#out] .. "\\^-1"
        elseif c == "." and input:sub(i, i+1) == ".*" then
          -- insert wildcard
          table.insert(out, ".*")
          i = i + 1 -- skip the '*'
        end
        i = i + 1
      end

      -- join with regex for star separator
      local parts = {}
      for _, piece in ipairs(out) do
        if piece == ".*" then
          table.insert(parts, ".*")
        else
          table.insert(parts, piece)
        end
      end
      local pattern = table.concat(parts, "\\s*\\*\\s*")

      -- set search register
      vim.fn.setreg("/", pattern)
      vim.cmd("normal! n")
    end, { nargs = 1 })
  end,
})
