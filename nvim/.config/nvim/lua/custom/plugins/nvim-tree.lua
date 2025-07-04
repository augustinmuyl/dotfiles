local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5 -- You can change this too

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  version = '*',
  config = function()
    local nvim_tree = require 'nvim-tree'

    -- Recommended: disable netrw to avoid conflicts
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Optional: set true if you want the tree to auto-close when it's the last window
    vim.g.nvim_tree_quit_on_open = 0

    nvim_tree.setup {
      sort_by = 'case_sensitive',
      view = {
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { '.DS_Store', 'node_modules' },
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      git = {
        enable = true,
        ignore = false,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
    }

    -- Keymaps (these override the defaults)
    vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle File Tree' })
    vim.keymap.set('n', '<leader>pe', ':NvimTreeFocus<CR>', { desc = 'Focus File Tree' })
  end,
}
