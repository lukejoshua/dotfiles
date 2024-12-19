---@type LazySpec[]
return {
    { import = "lazyvim.plugins.extras.editor.illuminate" },
    { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.test.core" },

    -- Github integration
    { import = "lazyvim.plugins.extras.util.octo" },

    -- TODO: pinned tabs instead of arrow/harpoon? Including <leader>1, <leader2>, <leader>h
    -- TODO: display harpooned files first in the bufferline
    { import = "lazyvim.plugins.extras.editor.harpoon2" },

    -------------------------------
    -- Override LazyVim Defaults --
    -------------------------------

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "kdl"
            }
        }
    },
    {
        "saghen/blink.cmp",
        opts = {
            signature = { enabled = true },
        }
    },
}
