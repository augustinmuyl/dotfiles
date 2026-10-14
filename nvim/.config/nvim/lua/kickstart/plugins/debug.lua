-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
        -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui',

        -- Required dependency for nvim-dap-ui
        'nvim-neotest/nvim-nio',

        -- Installs the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
    },
    keys = {
        -- Debug keymaps live under <leader>b, named after gdb's own commands
        -- (continue / step / next / finish), so no F-keys or Fn-holding needed.
        {
            '<leader>bc',
            function()
                require('dap').continue()
            end,
            desc = 'Debug: Start/Continue',
        },
        {
            '<leader>bs',
            function()
                require('dap').step_into()
            end,
            desc = 'Debug: Step Into',
        },
        {
            '<leader>bn',
            function()
                require('dap').step_over()
            end,
            desc = 'Debug: Step Over (Next)',
        },
        {
            '<leader>bf',
            function()
                require('dap').step_out()
            end,
            desc = 'Debug: Step Out (Finish)',
        },
        {
            '<leader>bb',
            function()
                require('dap').toggle_breakpoint()
            end,
            desc = 'Debug: Toggle Breakpoint',
        },
        {
            '<leader>bB',
            function()
                require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end,
            desc = 'Debug: Set Conditional Breakpoint',
        },
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        {
            '<leader>bu',
            function()
                require('dapui').toggle()
            end,
            desc = 'Debug: Toggle UI',
        },
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_installation = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'codelldb',
            },
        }

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        }

        -- Change breakpoint icons
        -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
        -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
        -- local breakpoint_icons = vim.g.have_nerd_font
        --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
        --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
        -- for type, icon in pairs(breakpoint_icons) do
        --   local tp = 'Dap' .. type
        --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
        --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
        -- end

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- C/C++ debugging via codelldb (EECS 281 etc.)
        dap.adapters.codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
                command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
                args = { '--port', '${port}' },
            },
        }

        -- program/args are resolved by nvim-dap via `pairs()`, which doesn't
        -- preserve field order, so two separate input() functions can prompt
        -- in the wrong order. A __call metatable forces one ordered prompt.
        local cpp_launch = setmetatable({
            name = 'Launch file',
            type = 'codelldb',
            request = 'launch',
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
        }, {
            __call = function(self)
                local program = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                -- args go straight to execve(), so shell redirection like `< file`
                -- isn't interpreted here; pull it out and hand it to codelldb's
                -- `stdio` field instead, which does real fd redirection.
                local args_string = vim.fn.input 'Program arguments (e.g. -m resize < in.txt): '
                local stdin_file = args_string:match '<%s*(%S+)%s*$'
                if stdin_file then
                    args_string = args_string:gsub('<%s*%S+%s*$', '')
                end
                return vim.tbl_extend('force', self, {
                    program = program,
                    args = vim.split(args_string, ' +', { trimempty = true }),
                    stdio = stdin_file and { stdin_file } or nil,
                })
            end,
        })
        local cpp_config = { cpp_launch }
        dap.configurations.c = cpp_config
        dap.configurations.cpp = cpp_config
    end,
}
