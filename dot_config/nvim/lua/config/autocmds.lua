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

-- Hack to remove duplicate status bar
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("LastStatusOnBufEnter", { clear = true }),
    callback = function()
        vim.o.laststatus = 0
    end,
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "help", "man" },
    desc = [[ Open new help splits to the right. ]],
    command = "wincmd L",
    group = help_split_group,
})

-- inspired by rushjs1/nuxt-goto.nvim
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.vue" },
    desc = [[ Set up Nuxt goto-definition ]],
    group = vim.api.nvim_create_augroup("NuxtGotoDefinition", {
        clear = false,
    }),
    -- TODO: make this actually work with goto definition
    once = true,
    callback = function()
        if vim.fn.finddir(".nuxt") ~= ".nuxt" then
            return
        end
        local original_definition = vim.lsp.buf.definition

        -- TODO: needs to integrate with fzf lsp implementation :/
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
            pattern = { "*.d.ts" },
            callback = function()
                -- vim.lsp.buf.definition = function()
                -- 	original_definition()

                vim.defer_fn(function()
                    local line = vim.fn.getline(".")
                    local path = string.match(line, '".-/(.-)"')
                    local file = vim.fn.expand("%")

                    if string.find(file, "components.d.ts") then
                        vim.cmd("edit " .. path)
                    end
                end, 100)
                -- end
            end,
        })
    end,
})
