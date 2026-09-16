return {
  { -- LaTeX compilation, Skim sync, folding, text objects/motions
    'lervag/vimtex',
    lazy = false, -- vimtex must not be lazy-loaded by the plugin manager (breaks :VimtexInverseSearch)
    init = function()
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_view_skim_sync = 1 -- forward search (jump in PDF) after every successful compile
      vim.g.vimtex_fold_enabled = 1

      -- latexmk watches the file on disk, not the buffer, so silently autosave
      -- on typing pauses (updatetime, 250ms) to get a rebuild without :w.
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        pattern = '*.tex',
        callback = function()
          if vim.bo.modified and vim.fn.expand '%' ~= '' then
            vim.cmd 'silent! write'
          end
        end,
      })
    end,
  },

  { -- cmp source for vimtex's citation/label/ref completion (see init.lua cmp sources for wiring)
    -- self-registers via after/plugin/cmp_vimtex.lua, no setup() call needed here
    'micangl/cmp-vimtex',
    ft = 'tex',
  },

  { -- Gilles Castel-style auto-expanding math snippets (fractions, sub/superscripts, symbols, ...)
    'iurimateus/luasnip-latex-snippets.nvim',
    ft = { 'tex', 'markdown' },
    dependencies = { 'L3MON4D3/LuaSnip', 'lervag/vimtex' },
    config = function()
      -- Re-assert in case this loads (FileType tex) before nvim-cmp's InsertEnter
      -- setup runs and would otherwise reset this to its default (false).
      require('luasnip').config.setup { enable_autosnippets = true }
      -- use_treesitter: the treesitter config (init.lua) now runs vim.treesitter.start()
      -- for tex buffers, which clears &syntax and breaks vimtex's synstack()-based
      -- in_mathzone() check (is_math always false -> snippets gated on being inside
      -- math, e.g. sr, //, never fire). Route math-zone detection through treesitter instead.
      require('luasnip-latex-snippets').setup { use_treesitter = true }

      -- Personal overrides: the pack hardcodes `dm` -> \[...\] for tex (it only
      -- uses $$ for markdown). Register our own with a higher priority so LuaSnip
      -- tries it first; the pack's original is untouched and still there as a fallback.
      -- Copy this pattern (new trig, new body, bump the priority) to override or add more.
      local ls = require 'luasnip'
      local utils = require 'luasnip-latex-snippets.util.utils'
      local not_math = utils.with_opts(utils.not_math, true) -- true: use treesitter, matches setup() above
      ls.add_snippets('tex', {
        ls.parser.parse_snippet(
          { trig = 'dm', name = 'Block Math ($$)', priority = 1000, condition = not_math },
          '$$\n\t${1}\n$$ $0'
        ),
        ls.parser.parse_snippet({ trig = 'mk', name = 'Math ($)', priority = 1000, condition = not_math }, '$${1}$$0'),
      }, { type = 'autosnippets' })
    end,
  },
}
