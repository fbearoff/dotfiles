local status_ok, grapple = pcall(require, "grapple")
if not status_ok then
  return
end

grapple.setup {
  log_level = "warn",

  scope = "git",

  ---Window options used for the popup menu
  popup_options = {
    relative = "editor",
    width = 60,
    height = 12,
    style = "minimal",
    focusable = false,
    border = "single",
  },

  integrations = {
    ---Support for saving tag state using resession.nvim
    resession = false,
  },
}
