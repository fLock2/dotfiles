local write_file = function(path, content)
  local file = io.open(path, "w")
  assert(file, "Failed to open file for writing: " .. path)
  file:write(content)
  file:close()
end


local get_appearance = function()
  local _, is_dark = hs.osascript.applescript(
    'tell application "System Events" to tell appearance preferences to return dark mode')
  return is_dark and "dark" or "light"
end

local light_theme = "catppuccin_latte"
local dark_theme = "catppuccin_mocha"

local last_appearance = get_appearance()

-- define as global variable to keep alive
watcher = hs.distributednotifications.new(function()
  local appearance = get_appearance()
  if appearance ~= last_appearance then
    write_file(os.getenv("HOME") .. "/.config/helix/themes/adaptive.toml",
      string.format("inherits = '%s'", appearance == "dark" and dark_theme or light_theme))
    -- command will fail silently if hx isn't running, which is good enough for me
    os.execute("kill -USR1 $(pgrep hx)")
  end
  last_appearance = appearance
end, 'AppleInterfaceThemeChangedNotification'):start()

PaperWM = hs.loadSpoon("PaperWM")
PaperWM:bindHotkeys({
     -- switch to a new focused window in tiled grid
      -- focus_left  = {{"cmd", "shift"}, "h"},
      -- focus_right = {{"cmd", "shift"}, "l"},
      focus_up    = {{"cmd", "shift"}, "k"},
      focus_down  = {{"cmd", "shift"}, "j"},

      -- switch windows by cycling forward/backward
      -- (forward = down or right, backward = up or left)
      focus_prev = {{"cmd", "shift"}, "h"},
      focus_next = {{"cmd", "shift"}, "l"},

      -- move windows around in tiled grid
      swap_left  = {{"alt", "shift"}, "h"},
      swap_right = {{"alt", "shift"}, "l"},
      swap_up    = {{"alt", "shift"}, "k"},
      swap_down  = {{"alt", "shift"}, "j"},

      -- position and resize focused window
      center_window        = {{"alt", "cmd"}, "c"},
      full_width           = {{"alt", "cmd"}, "f"},
      cycle_width          = {{"alt", "cmd"}, "r"},
      reverse_cycle_width  = {{"ctrl", "alt", "cmd"}, "r"},
      cycle_height         = {{"alt", "cmd", "shift"}, "r"},
      reverse_cycle_height = {{"ctrl", "alt", "cmd", "shift"}, "r"},

      -- increase/decrease width
      increase_width = {{"ctrl", "cmd"}, "l"},
      decrease_width = {{"ctrl", "cmd"}, "h"},

      -- move focused window into / out of a column
      slurp_in = {{"alt", "cmd"}, "i"},
      barf_out = {{"alt", "cmd"}, "o"},

      -- move the focused window into / out of the tiling layer
      toggle_floating = {{"alt", "cmd", "shift"}, "escape"},

      -- focus the first / second / etc window in the current space
      -- focus_window_1 = {{"cmd", "shift"}, "1"},
      -- focus_window_2 = {{"cmd", "shift"}, "2"},
      -- focus_window_3 = {{"cmd", "shift"}, "3"},
      -- focus_window_4 = {{"cmd", "shift"}, "4"},
      -- focus_window_5 = {{"cmd", "shift"}, "5"},
      -- focus_window_6 = {{"cmd", "shift"}, "6"},
      -- focus_window_7 = {{"cmd", "shift"}, "7"},
      -- focus_window_8 = {{"cmd", "shift"}, "8"},
      -- focus_window_9 = {{"cmd", "shift"}, "9"},

      -- switch to a new Mission Control space
      switch_space_l = {{"cmd", "shift"}, ","},
      switch_space_r = {{"cmd", "shift"}, "."},
      switch_space_1 = {{"cmd", "shift"}, "1"},
      switch_space_2 = {{"cmd", "shift"}, "2"},
      switch_space_3 = {{"cmd", "shift"}, "3"},
      switch_space_4 = {{"cmd", "shift"}, "4"},
      switch_space_5 = {{"cmd", "shift"}, "5"},
      switch_space_6 = {{"cmd", "shift"}, "6"},
      switch_space_7 = {{"cmd", "shift"}, "7"},
      switch_space_8 = {{"cmd", "shift"}, "8"},
      switch_space_9 = {{"cmd", "shift"}, "9"},

      -- move focused window to a new space and tile
      move_window_1 = {{"alt", "shift"}, "1"},
      move_window_2 = {{"alt", "shift"}, "2"},
      move_window_3 = {{"alt", "shift"}, "3"},
      move_window_4 = {{"alt", "shift"}, "4"},
      move_window_5 = {{"alt", "shift"}, "5"},
      move_window_6 = {{"alt", "shift"}, "6"},
      move_window_7 = {{"alt", "shift"}, "7"},
      move_window_8 = {{"alt", "shift"}, "8"},
      move_window_9 = {{"alt", "shift"}, "9"}
    })
-- })
PaperWM.window_gap  =  { top = 5, bottom = 5, left = 10, right = 10 }
PaperWM.window_filter:rejectApp("iTerm2")
PaperWM.window_filter:rejectApp("Exam4")
-- PaperWM.window_filter:rejectApp("iTerm")

-- number of fingers to detect a horizontal swipe, set to 0 to disable (the default)
PaperWM.swipe_fingers = 3

-- increase this number to make windows move farther when swiping
PaperWM.swipe_gain = 1.0
PaperWM:start()
WarpMouse = hs.loadSpoon("WarpMouse")
WarpMouse.margin = 8  -- optionally set how far past a screen edge the mouse should warp, default is 2 pixels
WarpMouse:start()
