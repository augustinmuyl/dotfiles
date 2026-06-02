return {
  'iamcco/markdown-preview.nvim',
  lazy = false,
  build = function()
    vim.fn['mkdp#util#install'](1)
  end,
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.g.mkdp_echo_preview_url = 1
  end,
  keys = {
    { '<leader>tm', '<cmd>MarkdownPreview<cr>', ft = 'markdown', desc = 'Markdown Preview (start)' },
    { '<leader>tM', '<cmd>MarkdownPreviewStop<cr>', ft = 'markdown', desc = 'Markdown Preview (stop)' },
  },
}
