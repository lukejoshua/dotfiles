return {
    { import = "lazyvim.plugins.extras.editor.aerial" },

    -------------------------------
    -- Override LazyVim Defaults --
    -------------------------------

    -- TODO: clean up status line

    {
        "folke/tokyonight.nvim",
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        enabled = false
    },


    -- TODO: consider edgy.nvim for creating layouts
    -- { import = "lazyvim.plugins.extras.ui.edgy" },

    {
        'stevearc/oil.nvim',
        config = function()
            local oil = require('oil')

            oil.setup({
                default_file_explorer = true,
            })

            -- https://github.com/stevearc/oil.nvim/issues/87#issuecomment-2179322405
            vim.api.nvim_create_autocmd("User", {
                pattern = "OilEnter",
                callback = vim.schedule_wrap(function(args)
                    if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
                        oil.open_preview({ split = "belowright" })
                    end
                end),
            })
        end,
        keys = {
            { "<C-n>", "<CMD>Oil<CR>", desc = "Open parent directory" }
        },
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
    }
}
