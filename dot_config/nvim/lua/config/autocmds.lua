-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Restore conceallevel for json files
vim.api.nvim_del_augroup_by_name("lazyvim_json_conceal")

--- Always open help buffers to the right instead of
--- at the bottom.
local help_split_group = vim.api.nvim_create_augroup("HelpSplit", {
    clear = true,
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "help", "man" },
    desc = [[ Open new help splits to the right. ]],
    command = "wincmd L",
    group = help_split_group,
})

--- Log all keypresses to a file for later processing
--- Just logs to a file for now, but doesn't do much more
--- Ideally I'd be able to check which mappings are activated

local logger_active = false
if logger_active then
    local keylogger_group = vim.api.nvim_create_augroup("KeyLogger", {
        clear = true,
    })

    -- use a different once-off event plez
    vim.api.nvim_create_autocmd("BufEnter", {
        once = true,
        desc = "Log keypresses to a file for later processing",
        group = keylogger_group,
        callback = function()
            -- File created manually for now
            -- NOTE: tilde doesn't work in here lol
            local log_file = "/home/luke/vim.log"
            local file = io.open(log_file, "r+")

            vim.api.nvim_create_autocmd("VimLeave", {
                callback = function()
                    if file then
                        file:close()
                    end
                end,
            })

            vim.notify("Starting Logger", vim.log.levels.INFO, {})

            local buffer = {}
            local namespace_id
            namespace_id = vim.on_key(function(k, t)
                if #t == 0 then
                    return
                end

                if file == nil then
                    vim.notify("Stopping Logger", vim.log.levels.ERROR)
                    vim.on_key(nil, namespace_id)
                    return
                end

                table.insert(
                    buffer,
                    string.format(
                        "[%s] %s",
                        os.date("%Y-%m-%d %H:%M:%S"),
                        vim.inspect(t)
                    )
                )
                if #buffer >= 128 then
                    vim.notify("Logging", vim.log.levels.INFO)
                    for _, line in ipairs(buffer) do
                        file:write(line .. "\n")
                    end
                    buffer = {}
                    file:flush()
                end
            end)
        end,
    })
end
