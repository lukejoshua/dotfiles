---@type LazySpec[]
return {
    { import = "lazyvim.plugins.extras.editor.aerial" },

    -------------------------------
    -- Override LazyVim Defaults --
    -------------------------------

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
    {
        "akinsho/bufferline.nvim",
        ---@param opts bufferline.UserConfig
        ---@return bufferline.UserConfig
        opts = function(_, opts)
            opts.options = {
                max_name_length = 30,
                numbers = "ordinal",
                show_close_icon = false,
                separator_style = "slope",
                style_preset = require('bufferline').style_preset.minimal
            }
            opts.highlights = {
                separator = {
                    fg = 'Normal',
                    bg = 'Normal'
                }

            }
            return opts
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            opts.sections = {
                lualine_a = {
                    {
                        "mode",
                        ---@param mode string
                        fmt = function(mode)
                            if string.find(mode, '-', nil, true) then
                                return mode:sub(1, 1) .. mode:sub(3, 3)
                            else
                                return mode:sub(1, 1)
                            end
                        end
                    }
                },
                lualine_b = {
                    LazyVim.lualine.root_dir(),
                },
                lualine_c = {
                    {
                        "filename",
                        -- Filename and parent dir, with tilder as the home directory
                        path = 4,
                        shorting_target = 40
                    },
                    {
                        "diagnostics",
                        symbols = {
                            error = LazyVim.config.icons.diagnostics.Error,
                            warn = LazyVim.config.icons.diagnostics.Warn,
                            info = LazyVim.config.icons.diagnostics.Info,
                            hint = LazyVim.config.icons.diagnostics.Hint,
                        },
                    },
                },
                lualine_x = {
                    Snacks.profiler.status(),
                    {
                        function() return require("noice").api.status.mode.get() end,
                        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                        color = function() return { fg = Snacks.util.color("Constant") } end,
                    },
                    {
                        function() return "  " .. require("dap").status() end,
                        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                        color = function() return { fg = Snacks.util.color("Debug") } end,
                    },
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = function() return { fg = Snacks.util.color("Special") } end,
                    },
                },
                lualine_y = {
                    {
                        "diff",
                        symbols = {
                            added = LazyVim.config.icons.git.added,
                            modified = LazyVim.config.icons.git.modified,
                            removed = LazyVim.config.icons.git.removed,
                        },
                        source = function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if gitsigns then
                                return {
                                    added = gitsigns.added,
                                    modified = gitsigns.changed,
                                    removed = gitsigns.removed,
                                }
                            end
                        end,
                    },
                    { "branch" }
                },
                lualine_z = {
                    {
                        'location',
                        fmt = function(str)
                            return 'Column ' .. string.gsub(str, '^.+%:', '')
                        end,
                    },
                },
            }
            opts.extensions = { "lazy" }
            return opts
        end
    },

    -- TODO: consider edgy.nvim for creating layouts
    -- { import = "lazyvim.plugins.extras.ui.edgy" },

    -------------------------------
    --    Non-Lazy UI Plugins    --
    -------------------------------

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
