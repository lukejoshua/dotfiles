-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ 'n', 'v' }, ';', ':', { desc = 'Command', remap = false, silent = false })

---@param offset number how many lines below the current one
local function add_blank_line(offset)
  return function()
    local repeated = vim.fn["repeat"]({ "" }, vim.v.count1)
    local line = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, line + offset, line + offset, true, repeated)
  end
end

vim.keymap.set('n', '<leader>[', add_blank_line(-1), { desc = 'Add blank line above' })
vim.keymap.set('n', '<leader>]', add_blank_line(0), { desc = 'Add blank line below' })

vim.keymap.set('n', '<leader>e', function()
  local current_file = vim.api.nvim_buf_get_name(0)
  local dir = vim.fs.dirname(current_file)
  local basename = vim.fs.basename(current_file)

  -- Get all the files in the current directory, except the current file
  local items = {}
  for name, type in vim.fs.dir(dir) do
    if name ~= basename and type == 'file' then
      table.insert(items, name)
    end
  end

  local special_filename_patterns = {
    -- Angular
    "component%.ts$",
    "component%.html$",
    "component%.scss$",

    -- SvelteKit
    "^%+page%.svelte$",
    "^%+page%.ts$",
    "^%+page%.server.ts$",
    "^%+layout%.svelte$",
    "^%+layout%.ts$",
    "^%+layout%.server.ts$",
    "^%+server%.ts$",
    "^%+error%.svelte$",
  }
  --- Get the first special file substring that matches
  --- @param name string
  --- @return integer|nil The index of the matching special file
  --- @return boolean If the filename is special
  local function index(name)
    for _, pattern in ipairs(special_filename_patterns) do
      local special_file_index = name:find(pattern)
      if special_file_index then
        return special_file_index, true
      end
    end

    return nil, false
  end

  table.sort(items, function(a, b)
    local indexA, aIsSpecial = index(a)
    local indexB, bIsSpecial = index(b)

    -- Special files preceed non-special files
    -- Sort two special files according to their order in `special_files`
    -- non-special files use default ordering for strings
    if aIsSpecial then
      if bIsSpecial then
        return indexA < indexB
      else
        return true
      end
    else
      if bIsSpecial then
        return false
      else
        return a < b
      end
    end
  end)

  return vim.ui.select(items, {
    prompt = 'Select file',
    kind = 'sibling-file-switcher',
  }, function(item)
    if item == nil then
      return
    end

    vim.cmd('e ' .. dir .. '/' .. item)
  end)
end, {
  desc = '[E]dit sibling',
})
