---@type LazySpec[]
return {
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.coding.yanky" },
    { import = "lazyvim.plugins.extras.editor.dial" },

    -------------------------------
    -- Override LazyVim Defaults --
    -------------------------------

    {
        "folke/flash.nvim",
        ---@type Flash.Config
        opts = {
            label = {
                rainbow = { enabled = true, shade = 6 }
            },
        }
    },
    {
        "echasnovski/mini.surround",
        opts = {
            -- 'ms' for 'mini.surround'
            mappings = {
                add = 'msa',     -- Add surrounding
                delete = 'msd',  -- Delete surrounding
                replace = 'msc', -- Replace surrounding
                -- Disable unused mappings
                find = "",
                find_left = "",
                highlight = "",
                update_n_lines = ""
            },
        },
        mappings = {
            { "ms", group = "Mini-surround" },
        }
    },
    {
        "monaqa/dial.nvim",
        opts = function(_, opts)
            local augend = require('dial.augend')
            local constant = augend.constant.new

            opts.dials_by_ft.zig = 'zig'
            opts.groups.zig = {
                constant({ elements = { "var", "const" } }),
                constant({ elements = { "and", "or" } }),
                constant({ elements = { "==", "!=" } })
            }

            vim.list_extend(opts.groups.default, {
                constant({ elements = { "break", "continue", "return" } }),
                constant({ elements = { "else", "else if" } }),
            })

            vim.list_extend(opts.groups.typescript, {
                constant({ elements = { "===", "!==" } })
            })

            return opts
        end
    },

    -------------------------------
    --  Non-Lazy Motion Plugins  --
    -------------------------------

    {
        "chrisgrieser/nvim-spider",

        opts = {
            skipInsignificantPunctuation = false
        },
        keys = vim.tbl_map(function(character)
            return {
                character,
                -- Has to be an Ex-command for dot-repeat to work
                "<cmd>lua require('spider').motion('" .. character .. "')<CR>",
                mode = { "n", "o", "x" },
            }
        end, { 'w', 'e', 'b' })
    },
    {
        'jinh0/eyeliner.nvim',
        opts = {
            highlight_on_key = false,
            disabled_filetypes = { "help" },
        }
    },
}
