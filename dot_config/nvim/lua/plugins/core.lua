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
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = { theme = "ivy" }
      }
    }
  },
  {
    'stevearc/oil.nvim',
    config = function()
      local oil = require('oil')

      oil.setup({
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
        rainbow = { enabled = true, shade = 9 }
      }
    }
  },

  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>uz", "<CMD>ZenMode<CR>", desc = "Toggle Zen Mode" }

    },

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
        add = 'ygs',            -- Add surrounding in Normal and Visual modes
        delete = 'dgs',         -- Delete surrounding
        replace = 'cgs',        -- Replace surrounding
        find = 'gsf',           -- Find surrounding (to the right)
        find_left = 'gsF',      -- Find surrounding (to the left)
        highlight = 'gsh',      -- Highlight surrounding
        update_n_lines = 'gsn', -- Update `n_lines`
      }
    }
  },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.editor.dial" },

  { import = "lazyvim.plugins.extras.dap.core" },

  { import = "lazyvim.plugins.extras.editor.aerial" },
  { import = "lazyvim.plugins.extras.editor.illuminate" },
  { import = "lazyvim.plugins.extras.ui.treesitter-context" },

  -- TODO: display harpooned files first in the bufferline
  { import = "lazyvim.plugins.extras.editor.harpoon2" },

  -- TODO: enable telescope extras, but read the docs first
  -- TODO: make sure I'm using fzf native
  -- TODO: frecency file search
  -- { import = "lazyvim.plugins.extras.editor.telescope" },

  -- TODO: consider blink if it's significantly better
  -- { import = "lazyvim.plugins.extras.coding.blink" },

  -- TODO: consider edgy.nvim for creating layouts
  -- { import = "lazyvim.plugins.extras.ui.edgy" },

  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },

  -- Languages
  { import = "lazyvim.plugins.extras.lang.angular" },
  { import = "lazyvim.plugins.extras.lang.java" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.vue" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.lang.zig" },

  -- Dotfiles
  { import = "lazyvim.plugins.extras.util.chezmoi" },
  { import = "lazyvim.plugins.extras.util.dot" },

  -- Github integration

  { import = "lazyvim.plugins.extras.util.octo" },
}
