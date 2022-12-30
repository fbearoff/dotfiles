local M = {
  "mfussenegger/nvim-dap",
  keys = "<leader>dc",
  dependencies = {
    { "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
    },
    { "jayp0521/mason-nvim-dap.nvim",
      config = {
        ensure_installed = { "bash", "python" },
        automatic_setup = true,
      },
    },
  },
}

function M.config()

  local mason_dap = require("mason-nvim-dap")
  local dap = require("dap")
  local dapui = require("dapui")

  mason_dap.setup_handlers {
    function(source_name)
      require('mason-nvim-dap.automatic_setup')(source_name)
    end,
  }

  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
  end
end

return M
