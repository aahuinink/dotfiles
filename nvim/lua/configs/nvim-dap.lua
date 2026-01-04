local dap = require("dap")

-- Use Windows lldb.exe
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "/home/aaron/tools/codelldb/extension/adapter/codelldb",
        args = {
            "--port",
            "${port}",
        },
    },
}

dap.configurations.cpp = {
    {
        name = "Remote Windows debug JUCE plugin in AudioPluginHost",
        type = "codelldb",
        request = "launch",
        cwd = "D:\\plugins\\debug",
        program = "D:\\plugins\\debug\\AudioPluginHost\\AudioPluginHost.exe",
        initCommands = {
            -- function()
            --     local plugin_name = vim.fn.input("Enter the plugin name: ")
            --     return "settings set target.debug-file-search-paths ~/repos/" .. plugin_name .. "/Builds/VisualStudio2022/x64/Debug/App"
            -- end,
            "platform select remote-windows",
            "platform connect connect://localhost:8080",
            "platform settings -w D:\\plugins\\debug",
        },
        preRunCommands = {
            -- function() return "target module add " .. vim.fn.input("Enter path to JUCE plugin: ", vim.fn.getcwd() .. "/Builds/") end,
            "target module add /home/aaron/repos/SimpleEQLinux/Builds/VisualStudio2022/x64/Debug/VST3/SimpleEQLinux.vst3/Contents/x86_64-win/SimpleEQLinux.vst3",
            "target symbols add /home/aaron/repos/SimpleEQLinux/Builds/VisualStudio2022/x64/Debug/VST3/SimpleEQLinux.pdb",
            "target symbols add /home/aaron/JUCE/extras/AudioPluginHost/Builds/VisualStudio2022/x64/Debug/App/AudioPluginHost.pdb",
        },
        exitCommands = {
            "platform disconnect",
        },
        stopOnEntry = false,
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
