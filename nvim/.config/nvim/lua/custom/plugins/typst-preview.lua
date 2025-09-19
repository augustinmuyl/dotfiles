return {
  { 'kaarmu/typst.vim', ft = 'typst' },
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    build = function()
      require('typst-preview').update()
    end,
    opts = {
      -- optional tweaks:
      -- port = 27121,
      -- open_browser = true,
    },
    keys = {
      { '<leader>tp', '<cmd>TypstPreview<cr>', desc = 'Typst Preview (start)' },
      { '<leader>tP', '<cmd>TypstPreviewStop<cr>', desc = 'Typst Preview (stop)' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = { servers = { tinymist = {} } }, -- brew install tinymist
  },
}
