local M = {
  "goolord/alpha-nvim",
  enabled = true,
  lazy = false,
  dependencies = "nvim-tree/nvim-web-devicons"
}

function M.config()

  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")
  dashboard.section.header.val = {
    [[ ___       __   ___  ___  ________  _________        ___  ___  ________  ___  ___  ___       ]],
    [[|\  \     |\  \|\  \|\  \|\   __  \|\___   ___\     |\  \|\  \|\   __  \|\  \|\  \|\  \      ]],
    [[\ \  \    \ \  \ \  \\\  \ \  \|\  \|___ \  \_|     \ \  \\\  \ \  \|\  \ \  \ \  \ \  \     ]],
    [[ \ \  \  __\ \  \ \   __  \ \   __  \   \ \  \       \ \  \\\  \ \   ____\ \  \ \  \ \  \    ]],
    [[  \ \  \|\__\_\  \ \  \ \  \ \  \ \  \   \ \  \       \ \  \\\  \ \  \___|\ \__\ \__\ \__\   ]],
    [[   \ \____________\ \__\ \__\ \__\ \__\   \ \__\       \ \_______\ \__\    \|__|\|__|\|__|   ]],
    [[    \|____________|\|__|\|__|\|__|\|__|    \|__|        \|_______|\|__|        ___  ___  ___ ]],
    [[                                                                              |\__\|\__\|\__\]],
    [[                                                                              \|__|\|__|\|__|]],
  }
  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", "<cmd>lua require('telescope.builtin').find_files({hidden=true}) <CR>"),
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
    dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
    dashboard.button("t", "  Find text", "<cmd>lua require('telescope.builtin').live_grep() <CR>"),
    dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
    dashboard.button("u", "  Update plugins", "<cmd>Lazy update<CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }
  dashboard.section.footer.val = {
    [[              ++++++++++                    ]],
    [[             ++  +     +++++                ]],
    [[             ++ ++  ++    ++++++++          ]],
    [[            ++ ++  +++++        +++         ]],
    [[           ++ ++  ++  ++ +++  ++  ++        ]],
    [[           ++ ++  +  ++  ++++++++  ++       ]],
    [[            +++++ ++ +++ ++++++++ +++       ]],
    [[             +++++++++++++ ++   + ++++      ]],
    [[                ++ +++      +++++ ++++      ]],
    [[                 ++++       +++++   +++     ]],
    [[                           ++ ++    ++++    ]],
    [[                           ++ ++    +++++   ]],
    [[                        +++ ++        +++++ ]],
    [[                        +++           +++++ ]],
    [[                 ++++   ++            ++++++]],
    [[  ++++++++    ++++++++++ +            +++ ++]],
    [[ +++++++++++++++      +++++++   ++    ++ +++]],
    [[++        ++++          + +++   +++     ++++]],
    [[++      +++             +++++++++++++++++ ++]],
    [[++     + +++++          +++ +++++++++++++++ ]],
    [[++   +++  +++++++++++++++++  +++++++++++++  ]],
    [[++ ++++     ++++++++++++        ++++++  +   ]],
    [[++++++++++++++         +++++      +++++++   ]],
    [[++++ +++++              ++++++++++++++++    ]],
    [[++ ++++++++++++            ++++++++++       ]],
    [[++ ++++++++++++    ++++++++  +++            ]],
    [[++++  ++++++++++++++++++++++++              ]],
    [[++         +++++++++++++++                  ]],
  }

  -- dashboard.section.footer.opts.hl = "Keyword"
  -- dashboard.section.header.opts.hl = "Keyword"
  dashboard.section.buttons.opts.hl = "Keyword"

  dashboard.opts.opts.noautocmd = true
  -- vim.cmd([[autocmd User AlphaReady echo 'ready']])
  alpha.setup(dashboard.opts)
end

return M
