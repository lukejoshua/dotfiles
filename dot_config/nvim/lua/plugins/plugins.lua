local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = LazyVim.config.get_kind_filter(ctx.bufnr) or false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

---@type LazySpec[]
return {
    -- https://github.com/LazyVim/LazyVim/issues/6039#issuecomment-2856227817
    { "mason-org/mason.nvim", version = "1.11.0" },
    { "mason-org/mason-lspconfig.nvim", version = "1.32.0" },

    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "ibhagwan/fzf-lua",
        keys = {
            {
            "<leader>sS",
            function()
                require("fzf-lua").lsp_document_symbols({
                regex_filter = symbols_filter,
                })
            end,
            desc = "Goto Symbol",
            },
            {
            "<leader>ss",
            function()
                require("fzf-lua").lsp_live_workspace_symbols({
                regex_filter = symbols_filter,
                })
            end,
            desc = "Goto Symbol (Workspace)",
            },
        }
    },
    {

        ---@type vim.lsp.Config
        "neovim/nvim-lspconfig",
        opts = {
            setup = {
                eslint = function()
                    require("lazyvim.util").lsp.on_attach(function(client)
                        if client.name == "eslint" then
                            client.server_capabilities.documentFormattingProvider = true
                        else
                            client.server_capabilities.documentFormattingProvider = false
                        end
                    end)
                end,
            },
            diagnostics = {
                virtual_text = false,
                virtual_lines = true,
                -- You can also customize other options here
                },
        },

        init = function()
            vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    vim.notify('formatting' .. diagnostic.source)
                    return string.format("%s", diagnostic.message)
                end,
            },
            })
        end
    },
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
                    "branch"
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
        "otavioschwanck/arrow.nvim",
        dependencies = {
            { "echasnovski/mini.icons" },
        },
        opts = {
            show_icons = true,
            leader_key = ',',        -- Recommended to be a single key
            buffer_leader_key = 'm', -- Per Buffer Mappings
        }
    },
    {
        'Wansmer/treesj',
        keys = {
            { "<leader>m", "<CMD>TSJToggle<CR>", desc = "TreeSJ toggle" },
        },
        dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
        opts = {
            ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
            use_default_keymaps = false,

            ---@type boolean Node with syntax error will not be formatted
            check_syntax_error = false,

            ---If line after join will be longer than max value,
            ---@type number If line after join will be longer than max value, node will not be formatted
            max_join_length = 1024
        },
    },
}
