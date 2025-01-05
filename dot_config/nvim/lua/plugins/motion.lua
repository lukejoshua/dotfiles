---@type LazySpec[]
return {
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
                rainbow = { enabled = true, shade = 6 },
            },
        },
    },
    {
        "monaqa/dial.nvim",
        opts = function(_, opts)
            local augend = require("dial.augend")
            local constant = augend.constant.new

            opts.dials_by_ft.zig = "zig"
            opts.groups.zig = {
                constant({ elements = { "var", "const" } }),
                constant({ elements = { "and", "or" } }),
                constant({ elements = { "==", "!=" } }),
            }

            vim.list_extend(opts.groups.default, {
                constant({ elements = { "break", "continue", "return" } }),
                constant({ elements = { "else", "else if" } }),
            })

            vim.list_extend(opts.groups.typescript, {
                constant({ elements = { "===", "!==" } }),
            })

            return opts
        end,
    },

    -- {
    --     "folke/ts-comments.nvim",
    --     keys = {
    --
    --         {
    --             '<leader>Ct',
    --             'OTODO:<Esc>gccA',
    --             mode = 'n',
    --             desc = "Add TODO comment above current line"
    --         }
    --     {}
    --
    -- vim.keymap.set('n', '<leader>Ct', function()
    --     vim.bo.
    -- end, {
    --     desc = "Add TODO comment above current line"
    -- })
    --
    -- vim.keymap.set('n', '<leader>Cn', 'ONOTE:<Esc>gccA', {
    --     desc = "Add NOTE comment above current line"
    -- })
    --
    -- vim.keymap.set('n', '<leader>Cf', 'OFIX:<Esc>gccA', {
    --     desc = "Add FIX comment above current line"
    -- })
    --     }
    -- },

    -------------------------------
    --  Non-Lazy Motion Plugins  --
    -------------------------------

    {
        "chrisgrieser/nvim-spider",
        event = "VeryLazy",
        opts = {
            skipInsignificantPunctuation = false,
        },
        keys = vim.tbl_map(function(character)
            return {
                character,
                -- Has to be an Ex-command for dot-repeat to work
                "<cmd>lua require('spider').motion('"
                    .. character
                    .. "')<CR>",
                mode = { "n", "o", "x" },
            }
        end, { "w", "e", "b" }),
    },
    {
        "jinh0/eyeliner.nvim",
        event = "VeryLazy",
        opts = {
            highlight_on_key = false,
            disabled_filetypes = { "help" },
        },
    },
    {
        "aaronik/treewalker.nvim",
        -- TODO: keybindings for swapping nodes
        keys = vim.tbl_map(function(direction)
            return {
                "<S-" .. direction .. ">",
                "<cmd>Treewalker " .. direction .. "<cr>",
                mode = { "n", "v" },
                desc = "Treewalker " .. direction,
            }
        end, { "Up", "Down", "Left", "Right" }),
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {
            keymaps = {
                insert = "<C-g>x",
                insert_line = "<C-g>X",
                normal = "yx",
                normal_cur = "yxx",
                normal_line = "yX",
                normal_cur_line = "yXX",
                visual = "X",
                visual_line = "gX",
                delete = "dx",
                change = "cx",
                change_line = "cX",
            },
        },
    },
}
