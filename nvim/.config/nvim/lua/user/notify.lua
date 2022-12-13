local status_ok, notify = pcall(require, "notify")
if not status_ok then
  return
end

notify.setup {
  -- Animation style
  stages = "fade_in_slide_out",

  -- Default timeout for notifications
  timeout = 0,

  -- Notification appearance
  render = "minimal",
}
