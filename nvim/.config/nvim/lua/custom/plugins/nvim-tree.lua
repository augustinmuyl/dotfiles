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
        width = 30,
        side = 'left',
        preserve_window_proportions = true,
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
