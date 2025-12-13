local dap = require("dap")

-- Use Windows lldb.exe
dap.adapters.codelldb = {
    name = "Windows LLDB",
    type = "server",
    host = "localhost",
    port = "8081",
    -- executable = {
    --     command = "/mnt/d/repos/codelldb/extension/adapter/codelldb.exe",
    --     args = {
    --         "--port",
    --         "${port}",
    --     },
    --     detached = false,
    -- },
}

local convert_to_winpath = function(wsl_path)
    local output_handle = io.popen("wslpath -w " .. wsl_path)
    local win_path = output_handle:read()
    output_handle:close()
    return win_path
end

dap.configurations.cpp = {
    {
        name = "Debug JUCE plugin in AudioPluginHost",
        type = "codelldb",
        request = "launch",
        program = convert_to_winpath("/mnt/d/repos/JUCE/extras/AudioPluginHost/Builds/VisualStudio2022/x64/Debug/App/AudioPluginHost.exe"),
        cwd = convert_to_winpath("${workspaceFolder}"),
        stopOnEntry = false,
        sourceMap = {
            ["D:\\repos\\"] = "/mnt/d/",
        }
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
