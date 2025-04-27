local dap = require("dap")

dap.adapters.lldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.expand("~/.local/share/nvim/mason/bin/codelldb"),
        args = { "--port", "${port}" },
    },
}

dap.configurations.rust = {
    {
        name = "rust-app",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.getcwd() .. "/target/debug/rust-app"
        end,
        args = { "" },
        cwd = "${workspaceFolder}",
        env = {
            RUST_LOG = "debug"
        },
        stopOnEntry = false,
    },
}
