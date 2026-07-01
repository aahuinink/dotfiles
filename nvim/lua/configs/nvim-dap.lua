local dap, dapui = require "dap", require "dapui"

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end


-- Use codelldb
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
        postRunCommands = {
            "sett"
        },
        exitCommands = {
            "platform disconnect",
        },
        stopOnEntry = false,
    },
    {
        name = "Debug local file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },

}

dap.configurations.c = dap.configurations.cpp
