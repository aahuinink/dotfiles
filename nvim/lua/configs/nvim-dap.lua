local dap, dapui, map, unmap = require("dap"), require("dapui"), vim.keymap.set, vim.keymap.del

dapui.setup()

local dap_session_keymap = {
    { "<Down>", dap.step_over, { remap = false, buffer = true, desc = "Dap Step Over"} },
    { "<Right>", dap.step_into, { remap = false, buffer = true, desc = "Dap Step Into"} },
    { "<Left>", dap.step_out, { remap = false, buffer = true, desc = "Dap Step Out"} },
    { "<Up>", dap.restart_frame, { remap = false, buffer = true, desc = "Dap Restart Frame"} },
    { "<Leader>dc", dap.continue, { buffer = true, desc = "Dap Continue", remap = false} },
}

local create_dap_keymap = function(arg_table)
    for _, keymap_args in ipairs(arg_table) do
        map("n", unpack(keymap_args))
    end
end

local destroy_dap_keymap = function(arg_table)
    for _, keymap_args in ipairs(arg_table) do
        unmap("n", keymap_args[1], { buffer = true })
    end
end

dap.listeners.before['attach']['dapui_config'] = function(session, body)
  dapui.open()
  create_dap_keymap(dap_session_keymap)
end
dap.listeners.before['launch']['dapui_config'] = function(session, body)
  dapui.open()
  create_dap_keymap(dap_session_keymap)
end

dap.listeners.before['event_terminated']['dapui_config'] = function(session, body)
  dapui.close()
end

dap.listeners.before['event_exited']['dapui_config'] = function(session, body)
  dapui.close()
  destroy_dap_keymap(dap_session_keymap)
end

dap.adapters.codelldb = {
    name = "codelldb",
    type = "executable",
    command = "codelldb"
}

dap.configurations.cpp = {
    {
        name = "CodeLLDB",
        type = "codelldb",
        request = "launch",
        program = function()
            local executable_path
            if vim.b.last_debuggee_path == nil then
                executable_path = vim.fn.getcwd() .. '/'
            else 
                executable_path = vim.b.last_debuggee_path
            end
            local debuggee = vim.fn.input('Path to executable: ', executable_path, 'file')
            vim.b.last_debuggee_path = debuggee
            return debuggee
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}

dap.configurations.c = dap.configurations.cpp
