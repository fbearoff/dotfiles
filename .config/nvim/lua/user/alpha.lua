local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

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
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", "require(telescope.builtin.live_grep({hidden=true})) <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("u", "  Update plugins" , "<cmd>PackerSync<CR>"),
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
