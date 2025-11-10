return {
  'github/copilot.vim',
  init = function()
    vim.g.copilot_no_tab_map = true
  end,
  config = function()
    vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      silent = true,
      replace_keycodes = false,
    })
  end,
  event = 'InsertEnter',
}
