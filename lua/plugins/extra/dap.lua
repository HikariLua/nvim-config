return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
  },
  keys = {
    {
      "<leader>dds",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes, { border = "rounded" })
      end,
      desc = "DAP Scopes",
    },
    { "<F6>",  function() require("dap.ui.widgets").hover(nil, { border = "rounded" }) end },
    { "<F7>",  "<CMD>DapTerminate<CR>",                                                    desc = "DAP Terminate" },
    { "<F17>", function() require("dap").run_last() end,                                   desc = "Run Last" },
    {
      "<F21>",
      function()
        vim.ui.input(
          { prompt = "Breakpoint condition: " },
          function(input) require("dap").set_breakpoint(input) end
        )
      end,
      desc = "Conditional Breakpoint",
    },
  },
  config = function()
    -- Signs
    local sign = vim.fn.sign_define

    local dap_round_groups = { "DapBreakpoint", "DapBreakpointCondition", "DapBreakpointRejected", "DapLogPoint" }
    for _, group in pairs(dap_round_groups) do
      sign(group, { text = "●", texthl = group })
    end

    local dap = require("dap")

    -- Adapters
    -- C, C++, Rust
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }

    -- Python
    dap.adapters.python = function(cb, config)
      if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "localhost"
        cb({
          type = "server",
          port = assert(port, "`connect.port` is required for a python `attach` configuration"),
          host = host,
          options = {
            source_filetype = "python",
          },
        })
      else
        local debugpy = require("mason-registry").get_package("debugpy")
        cb({
          type = "executable",
          command = debugpy:get_install_path() .. "/venv/bin/python3",
          args = { "-m", "debugpy.adapter" },
          options = {
            source_filetype = "python",
          },
        })
      end
    end
    -- JS, TS
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
      },
    }
  end,
}
