return {
  {
    "lkhphuc/jupyter-kernel.nvim",
    opts = {
      inspect = {
        window = {
          max_width = 84,
        },
      },
      timeout = 0.5,
    },
    cmd = "JupyterAttach",
    build = ":UpdateRemotePlugins",
    keys = {
      { "<localleader>k", "<Cmd>JupyterInspect<CR>", desc = "Inspect Object in Kernel" },
      { "<localleader>J", "<Cmd>JupyterAttach <CR>", desc = "Jupyter Attach" },
    },
  },
}
