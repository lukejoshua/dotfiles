---@type LazySpec[]
return {
    { import = "lazyvim.plugins.extras.editor.illuminate" },
    { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.test.core" },

    -- Github integration
    { import = "lazyvim.plugins.extras.util.octo" },

    -------------------------------
    -- Override LazyVim Defaults --
    -------------------------------

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "kdl",
            },
        },
    },
    {
        "saghen/blink.cmp",
        opts = {
            signature = { enabled = true },
        },
    },
    {
        "ibhagwan/fzf-lua",
        event = "VeryLazy",
    },
}
