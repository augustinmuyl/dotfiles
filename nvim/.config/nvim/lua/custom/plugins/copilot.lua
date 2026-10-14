return {
    'github/copilot.vim',
    init = function()
        vim.g.copilot_no_tab_map = true
        -- Use the language server bundled with the plugin instead of letting `npx`
        -- pull a newer (incompatible) version. The default `^1.400.0` constraint was
        -- resolving to 1.500.x, which fails auth with "Invalid GitHub server URL".
        vim.g.copilot_version = false
    end,
    config = function()
        vim.keymap.set('i', '<C-y>', 'copilot#Accept("\\<CR>")', {
            expr = true,
            silent = true,
            replace_keycodes = false,
        })
    end,
    event = 'InsertEnter',
}
