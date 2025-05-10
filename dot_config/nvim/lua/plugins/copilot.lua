---@type LazySpec[]
return {
    {
        "copilotlsp-nvim/copilot-lsp",
        init = function()
            vim.g.copilot_nes_debounce = 400
            vim.lsp.enable("copilot_ls")
            vim.keymap.set("n", "<CR>", function()
                -- Try to jump to the start of the suggestion edit.
                -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
                local nes = require("copilot-lsp.nes")
                local _ = nes.walk_cursor_start_edit()
                or (
                nes.apply_pending_nes() and nes.walk_cursor_end_edit()
            )
            end)
        end,
        dependencies = {
            {
                "saghen/blink.cmp",
                opts = {
                    keymap = {
                        -- preset = "super-tab",
                        ["<CR>"] = {
                            function(cmp)
                                if vim.b[vim.api.nvim_get_current_buf()].nes_state then
                                    cmp.hide()
                                    local nes = require("copilot-lsp.nes")
                                    return (nes.apply_pending_nes() and nes.walk_cursor_end_edit())
                                end
                                if cmp.snippet_active() then
                                    return cmp.accept()
                                else
                                    return cmp.select_and_accept()
                                end
                            end,
                            "snippet_forward",
                            "fallback",
                        },
                    },
                }
            }
        }
    },
    {
        "zbirenbaum/copilot.lua",
        opts = {
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = false,
                auto_trigger = true,
                debounce = 75,         -- Debounce time in ms
                keymap = {
                    accept = "<Tab>",  -- Changed from default <M-l>
                    accept_word = "<M-w>", -- Added accept word mapping
                    accept_line = "<M-l>", -- Added accept line mapping
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
                hide_during_completion = true,
                trigger_on_accept = true, -- Triggers new completion after accepting
            },
            -- LSP server options
            server_opts_overrides = {
                -- Improve token usage efficiency
                settings = {
                    advanced = {
                        listCount = 0,      -- Number of completions for panel
                        inlineSuggestCount = 1, -- Number of completions for getCompletions
                    },
                },
                -- Use consistent encoding with other LSPs
                -- offset_encoding = "utf-16",
            },
        }
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "j-hui/fidget.nvim",
            {
                "ravitemer/mcphub.nvim", -- Manage MCP servers
                cmd = "MCPHub",
                build = "npm install -g mcp-hub@latest",
                config = true,
            },
            -- TODO: find a way to make this work
            -- {
            --     "Davidyz/VectorCode", -- Index and search code in your repositories
            --     version = "*",
            --     build = "pipx upgrade vectorcode",
            --     dependencies = { "nvim-lua/plenary.nvim" },
            -- },
            {
                "MeanderingProgrammer/render-markdown.nvim",
                ft = { "markdown", "codecompanion" }
            },
        },
        init = function()
            vim.cmd([[cab cc CodeCompanion]])
        end,
        event = "VeryLazy",
        keys = {
            { "<leader>a", group = "AI" },
            { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = " AI: Inline" },
            { "<leader>as", "<cmd>CodeCompanionActions<cr>", desc = " AI: Select action" },
            { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = " AI: Toggle chat" },
            { "<leader>af", "<cmd>CodeCompanionChat Add<cr>", desc = " AI: Add file" },
            { "<leader>ac", "<cmd>CodeCompanionCmd<cr>", desc = " AI: Command" },
        },
        opts = {
            -- TODO: where can these be set?
            -- reasoning_effort = "medium",
            -- temperature = 0,
            -- max_tokens = 15000,
            -- top_p = 1,
            -- n = 1,

            adapters = {
                -- TODO: reasoning, fast, etc
                copilot = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = {
                            model = {
                                -- "gpt-4.1"
                                -- "o3-mini"
                                -- "claude-3.5-sonnet"
                                -- "gemini-2.5-pro"
                                -- "o3"
                                -- "gpt-4o"
                                -- "claude-3.7-sonnet-thought"
                                -- "o4-mini"
                                -- "o1"
                                -- "gemini-2.0-flash-001"
                                default = "gemini-2.5-pro",
                            },
                            reasoning_effort = {
                                -- high, medium, low
                                default = "high",
                            },
                            -- num_ctx = {
                            --   default = 16384,
                            -- },
                            -- num_predict = {
                            --   default = -1,
                            -- },
                        },
                    })
                end,

                copilot_fast = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = {
                            model = {
                                -- "gpt-4o"
                                -- "gemini-2.0-flash-001"
                                -- "o3-mini"
                                -- "claude-3.7-sonnet"
                                -- "o1"
                                -- "claude-3.5-sonnet"
                                -- "claude-3.7-sonnet-thought"
                                default = "o3-mini",
                            },
                            reasoning_effort = {
                                -- high, medium, low
                                default = "low",
                            },
                            -- num_ctx = {
                            --   default = 16384,
                            -- },
                            -- num_predict = {
                            --   default = -1,
                            -- },
                        },
                    })
                end,
            },

            extensions = {
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        make_vars = true,
                        make_slash_commands = true,
                        show_result_in_chat = true,
                    },
                },
                -- vectorcode = {
                --     opts = {
                --         add_tool = true,
                --     },
                -- },
            },

            -- NOTE: Default strategy is copilot
            -- TODO: additional keybindings?
            strategies = {
                chat = {
                    adapter = "copilot"
                    -- TODO: keymap for changing model
                },
                inline = {
                    adapter = "copilot_fast"
                },
                cmd = {
                    adapter = "copilot"
                },
            },

            display = {
                --    action_palette = {
                --        width = 95,
                --        height = 10,
                --        prompt = "Prompt ", -- Prompt used for interactive LLM calls
                --        provider = "snacks", -- "default", "telescope", "mini_pick" or "snacks"
                --        opts = {
                --          show_default_actions = true, -- Show the default actions in the action palette?
                --          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
                --        },
                --     },
                diff = {
                    enabled = true,
                    -- Close an open chat buffer if the total columns of your display are less than 240
                    close_chat_at = 240,
                    -- vertical|horizontal split for default provider
                    layout = "vertical",
                    opts = {
                        "iwhiteall",
                        "vertical",
                        "internal",
                        "filler",
                        "closeoff",
                        "algorithm:minimal",
                        "followwrap",
                        "linematch:120"
                    },
                    -- default|mini_diff
                    provider = "default",
                }
            },
        }
    },
}


