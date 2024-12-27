---@type LazySpec[]
return {
    { import = "lazyvim.plugins.extras.lang.angular" },
    { import = "lazyvim.plugins.extras.lang.java" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.vue" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.zig" },

    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.linting.eslint" },

    { import = "lazyvim.plugins.extras.util.chezmoi" },
    { import = "lazyvim.plugins.extras.util.dot" },

    -------------------------------
    -- Override LazyVim Defaults --
    -------------------------------

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                zls = {
                    enable_build_on_save = true,
                    build_on_save_args = { "install", "-Dtarget=wasm32-wasi", "-fwasmtime" }
                },
            },
        },
    },
    {
        "lawrence-laz/neotest-zig",
        -- supports zig 0.13
        tag = "1.3.1",
        event = "VeryLazy"
    },

}
