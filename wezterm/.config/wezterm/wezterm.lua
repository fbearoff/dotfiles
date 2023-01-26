local wezterm = require 'wezterm'

local wsl_domains = wezterm.default_wsl_domains()
--
for _, dom in ipairs(wsl_domains) do
  dom.default_cwd = "~"
end

local font_primary = "MesloLGS NF"

local function font(name, params)
  return wezterm.font(name, params)
end

local launch_menu = {}
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'pwsh.exe' },
  })

  -- Enumerate any WSL distributions that are installed and add those to the menu
  local success, wsl_list, wsl_err = wezterm.run_child_process { 'wsl.exe', '-l' }
  if success then
    -- `wsl.exe -l` has a bug where it always outputs utf16:
    -- https://github.com/microsoft/WSL/issues/4607
    -- So we get to convert it
    wsl_list = wezterm.utf16_to_utf8(wsl_list)

    for idx, line in ipairs(wezterm.split_by_newlines(wsl_list)) do
      -- Skip the first line of output; it's just a header
      if idx > 1 then
        -- Remove the "(Default)" marker from the default line to arrive
        -- at the distribution name on its own
        local distro = line:gsub(' %(Default%)', '')

        -- Add an entry that will spawn into the distro with the default shell
        table.insert(launch_menu, {
          label = distro .. ' (WSL default shell)',
          args = { 'wsl.exe', '--distribution', distro },
        })

        -- Here's how to jump directly into some other program; in this example
        -- its a shell that probably isn't the default, but it could also be
        -- any other program that you want to run in that environment
        table.insert(launch_menu, {
          label = distro .. ' (WSL zsh login shell)',
          args = {
            'wsl.exe',
            '--distribution',
            distro,
            '--exec',
            '/bin/zsh',
            '-l',
          },
        })
      end
    end
  end
end

local config = {
  force_reverse_video_cursor = true,
  font = font(font_primary),
  font_size = 13,
  colors = require('colors.kanagawa'),
  enable_scroll_bar = false,

  -- tab bar
  enable_tab_bar = true,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = false,
  tab_max_width = 25,
  show_tab_index_in_tab_bar = false,
  switch_to_last_active_tab_when_closing_tab = true,

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  wsl_domains = wsl_domains,
  default_domain = "WSL:Arch",
  default_prog = { "wsl.exe" },

  -- wsl_domains = {
  --   {
  --     name = "WSL:Arch",
  --     distribution = "Arch",
  --     username = "frank",
  --     default_cwd = "/home/frank",
  --     default_prog = { "zsh" },
  --   },
  -- },
}


return config
