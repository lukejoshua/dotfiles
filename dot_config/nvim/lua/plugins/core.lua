---@type LazySpec[]
return {
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
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "kdl"
      }
    }
  },
  {
    'stevearc/oil.nvim',
    config = function()
      local oil = require('oil')

      oil.setup({
        default_file_explorer = true,
        keymaps = {
          ["<C-m>"] = "actions.preview",
        }
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
  },
  {
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      label = {
        -- style = "overlay",
        rainbow = { enabled = true, shade = 6 }
      },
    }
  },
  {
    "chrisgrieser/nvim-spider",
    lazy = true
  },
  {
    'jinh0/eyeliner.nvim',
    opts = {

      highlight_on_key = false,
      -- dim all other characters if set to true (recommended!)
      dim = false,

      -- set the maximum number of characters eyeliner.nvim will check from
      -- your current cursor position; this is useful if you are dealing with
      -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
      max_length = 9999,

      -- filetypes for which eyeliner should be disabled;
      -- e.g., to disable on help files:
      -- disabled_filetypes = {"help"}
      disabled_filetypes = {},

      -- buftypes for which eyeliner should be disabled
      -- e.g., disabled_buftypes = {"nofile"}
      disabled_buftypes = {},

      -- see section on advanced configuration for more information
      default_keymaps = true,
    }
  },

  -- TODO: clean up status line
  -- TODO: pinned tabs instead of arrow/harpoon? Including <leader>1, <leader2>, <leader>h
  -- TODO: consider different keymaps
  -- TODO: supertab?
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = 'msa',     -- Add surrounding in Normal and Visual modes
        delete = 'msd',  -- Delete surrounding
        replace = 'msc', -- Replace surrounding
        -- find = 'gsf',           -- Find surrounding (to the right)
        -- find_left = 'gsF',      -- Find surrounding (to the left)
        -- highlight = 'gsh',      -- Highlight surrounding
        -- update_n_lines = 'gsn', -- Update `n_lines`
      },

    },
    mappings = {
      { "ms",  group = "Mini-surround" },
      { "msa", desc = "add surrounding" },
      { "msd", desc = "delete surrounding" },
      { "msc", desc = "change surrounding" },
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false
  },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.editor.dial" },
  {
    "monaqa/dial.nvim",
    opts = function(_, opts)
      local augend = require('dial.augend')
      opts.dials_by_ft.zig = 'zig'
      opts.groups.zig = {
        augend.constant.new({ elements = { "var", "const" } }),
        augend.constant.new({ elements = { "and", "or" } }),
        augend.constant.new({ elements = { "==", "!=" } })
      }

      vim.list_extend(opts.groups.default, {
        augend.constant.new({ elements = { "break", "continue", "return" } }),
        augend.constant.new({ elements = { "else", "else if" } }),
      })

      vim.list_extend(opts.groups.typescript, {
        augend.constant.new({ elements = { "===", "!==" } })
      })
      return opts
    end
  },

  { import = "lazyvim.plugins.extras.dap.core" },

  { import = "lazyvim.plugins.extras.editor.aerial" },
  { import = "lazyvim.plugins.extras.editor.illuminate" },
  { import = "lazyvim.plugins.extras.ui.treesitter-context" },

  -- TODO: display harpooned files first in the bufferline
  { import = "lazyvim.plugins.extras.editor.harpoon2" },

  -- TODO: consider edgy.nvim for creating layouts
  -- { import = "lazyvim.plugins.extras.ui.edgy" },

  { import = "lazyvim.plugins.extras.test.core" },

  -- Languages
  { import = "lazyvim.plugins.extras.lang.angular" },
  { import = "lazyvim.plugins.extras.lang.java" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.vue" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.lang.zig" },

  -- Zig
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
    tag = "1.3.1"
  },

  -- JS
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },

  -- Dotfiles
  { import = "lazyvim.plugins.extras.util.chezmoi" },
  { import = "lazyvim.plugins.extras.util.dot" },

  -- Github integration

  { import = "lazyvim.plugins.extras.util.octo" }
}
