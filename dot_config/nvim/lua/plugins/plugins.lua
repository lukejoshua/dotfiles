---@type LazySpec[]
return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
    },
    {
        "folke/noice.nvim",
        opts = {
            presets = {
                lsp_doc_border = true,
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        opts = {
            extensions = { 'lazy' },
            sections = {

                lualine_a = {
                    {
                        "mode",
                        ---@param mode string
                        fmt = function(mode)
                            if string.find(mode, "-", nil, true) then
                                return mode:sub(1, 1) .. mode:sub(3, 3)
                            else
                                return mode:sub(1, 1)
                            end
                        end,
                    },
                },
                lualine_b = {
                    LazyVim.lualine.root_dir(),
                },
                lualine_c = {
                    {
                        "filetype",
                        icon_only = true,
                        separator = "",
                        padding = { left = 1, right = 0 }
                    },
                    { LazyVim.lualine.pretty_path() },
                },
                lualine_y = {
                    "branch"
                },
                lualine_z = {
                    "location",
                },
            }

        }
    },
    {
        "folke/flash.nvim",
        ---@type Flash.Config
        opts = {
            label = {
                rainbow = { enabled = true, shade = 6 },
            },
        },

        keys = {
            { "s", mode = { "n", "x", "o" }, false },
            {
                "s",
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
        },
    },

    {
        "stevearc/oil.nvim",
        config = function()
            local oil = require("oil")

            oil.setup({
                default_file_explorer = true,
            })

            -- https://github.com/stevearc/oil.nvim/issues/87#issuecomment-2179322405
            vim.api.nvim_create_autocmd("User", {
                pattern = "OilEnter",
                callback = vim.schedule_wrap(function(args)
                    if
                        vim.api.nvim_get_current_buf() == args.data.buf
                        and oil.get_cursor_entry()
                    then
                        oil.open_preview({ split = "belowright" })
                    end
                end),
            })
        end,
        keys = {
            { "<C-n>", "<CMD>Oil<CR>", desc = "Open parent directory" },
        },
        dependencies = {
            { "echasnovski/mini.icons", opts = {} },
        },
    },

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
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {
            keymaps = {
                normal = "ys",
                change = "cs",
            },
        },
    },
    {
        "vimpostor/vim-tpipeline",
        dependencies = {
            "nvim-lualine/lualine.nvim",
        },
        lazy = false,
        config = function()
            vim.g.tpipeline_fillcentre = 1
            vim.g.tpipeline_restore = 1
            vim.g.tpipeline_clearstl = 1
        end,
    },
    {
        "otavioschwanck/arrow.nvim",
        dependencies = {
            { "echasnovski/mini.icons" },
        },
        opts = {
            show_icons = true,
            leader_key = ',',        -- Recommended to be a single key
            buffer_leader_key = 'm', -- Per Buffer Mappings
        }
    }
}
