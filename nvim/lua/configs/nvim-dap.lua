local dap = require("dap")

-- Use Windows lldb.exe
dap.adapters.codelldb = {
    name = "Windows LLDB",
    type = "server",
    port = 8080,
    -- executable = { command = "/mnt/c/Users/a_hui/repos/codelldb/adapter/codelldb.exe",
    --     args = {
    --         "--port",
    --         "8080",
    --     },
    -- --     detached = false,
    -- },
}

local convert_to_winpath = function(wsl_path)
    local output_handle = io.popen("wslpath -w " .. wsl_path)
    local win_path = output_handle:read()
    output_handle:close()
    return win_path
end

local get_remote_pid = function()
    return vim.fn.input("Enter PID of target on remote host: ")
end

dap.configurations.cpp = {
    {
        name = "Debug JUCE plugin in AudioPluginHost",
        type = "codelldb",
        request = "attach",
        initCommands = {
            "platform select remote-windows",
            "platform connect connect://192.168.48.1:8081",
            },
        targetCreateCommands = {
            "attach AudioPluginHost",
            -- function()
            --     return vim.fn.input("Remote file to debug: ")
            -- end,
        },
        env = {
            PATH = "...",
            },
        stopOnEntry = false,
        -- sourceMap = {
        --     ["C:\\"] = "/mnt/c/",
        -- }
    },
    {
        name = "Debug Windows .exe",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}
