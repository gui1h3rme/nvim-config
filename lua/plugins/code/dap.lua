return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
"igorlfs/nvim-dap-view",
    "nvim-neotest/nvim-nio",
    "mxsdev/nvim-dap-vscode-js",
    -- build debugger from source
    {
      "microsoft/vscode-js-debug",
      version = "1.x",
      build = "npm i && npm run compile vsDebugServerBundle && mv dist out"
    }
  },
  config = function()
    local dap, dapui = require('dap'), require('dap-view')

    for _, adapter in ipairs({ 'pwa-chrome' }) do
      dap.adapters[adapter] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.resolve(vim.fn.stdpath('data')) .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            "${port}",
          },
        },
      }
    end

    for _, language in ipairs({ 'svelte', 'javascript', 'typescript' }) do
      dap.configurations[language] = {{
        type = "pwa-chrome",
        name = "Launch Chrome to debug client",
        request = "launch",
        url = "http://localhost:5173",
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}/src",
        -- skip files from vite's hmr
        skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
        userDataDir = '/tmp/chrome/data'
      }}
    end

    vim.api.nvim_set_hl(0, 'DapColor', { fg = require('nightfox.palette.nightfox').palette.orange.base })

    vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapColor', linehl= '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapColor', linehl= '', numhl = '' })
    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapColor', linehl= '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DapColor', linehl= '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '◐', texthl = 'DapColor', linehl= '', numhl = '' })

    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({ reset = true })
    end
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end
}
