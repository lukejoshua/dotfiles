-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ 'n', 'v' }, ';', ':', { desc = 'Command', remap = false, silent = false })

local function get_prefix(s)
  local index = string.find(s, '.', 1, true)
  return index and string.sub(s, 1, index - 1) or ''
end

local function has_prefix(s, prefix)
  return string.find(s, prefix .. '.', 1, true) == 1
end


local angular_defaults = {
  "component.ts",
  "component.html",
  "analytics.ts",
  "component.scss",
}

local svelte_defaults = {
  "+page.svelte",
  "+page.ts",
  "+page.server.ts",
  "+layout.svelte",
  "+layout.ts",
  "+layout.server.ts",
  "+server.ts",
  "+error.svelte",
}

-- TODO: maybe this can be simplified so that prefixes aren't the focus
vim.keymap.set('n', '<leader>cd', function()
  local current_file = vim.api.nvim_buf_get_name(0)
  local basename = vim.fs.basename(current_file)
  local defaults = basename:sub(1, 1) == '+' and svelte_defaults or angular_defaults

  local dir = vim.fs.dirname(current_file)
  local prefix = get_prefix(basename)

  local items = {}
  for name, type in vim.fs.dir(dir) do
    if has_prefix(name, prefix) and name ~= basename and type == 'file' then
      table.insert(items, name)
    end
  end

  local function index(xs, x)
    for idx, value in ipairs(xs) do
      if value == x then return idx end
    end

    return nil
  end

  table.sort(items, function(a, b)
    local aHasPrefix = has_prefix(a, prefix)
    local bHasPrefix = has_prefix(b, prefix)

    if aHasPrefix and bHasPrefix then
      local indexA = index(defaults, string.sub(a, #prefix + 2))
      local indexB = index(defaults, string.sub(b, #prefix + 2))

      if indexA == nil and indexB == nil then
        return a < b
      end

      if indexA ~= nil and indexB ~= nil then
        return indexA < indexB
      end

      if indexA == nil then
        return false
      end

      if indexB == nil then
        return true
      end

      return a < b
    elseif aHasPrefix then
      return true
    elseif bHasPrefix then
      return false
    else
      return a < b
    end
  end)

  return vim.ui.select(items, {
    prompt = 'Select file: (' .. prefix .. ')',
    format_item = function(item)
      if not has_prefix(item, prefix) then
        return item
      end

      return string.sub(item, #prefix + 2)
    end,
    kind = 'ngswitch',
  }, function(item)
    if item == nil then
      return
    end

    vim.cmd('e ' .. dir .. '/' .. item)
  end)
end, {
  desc = 'File Switcher',
})
