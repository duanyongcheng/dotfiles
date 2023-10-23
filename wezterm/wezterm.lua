local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Catppuccin Frappe"
  else
    return "Catppuccin Frappe"
  end
end

-- Sttings
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.font = wezterm.font_with_fallback({
  { family = "Andale Mono",              scale = 1.5 },
  { family = "FiraMono Nerd Font",       scale = 1.4 },
  { family = "FantasqueSansM Nerd Font", scale = 1.2 },
})
config.window_background_opacity = 0.8
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "main"

-- config.native_macos_fullscreen_mode = true

config.hide_tab_bar_if_only_one_tab = true

-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.5
}

config.initial_rows = 40
config.initial_cols = 120
config.default_cursor_style = "BlinkingBar"

-- Keys
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  -- Send C-a when pressing C-a twice
  { key = "a",          mods = "LEADER|CTRL", action = act.SendKey { key = "a", mods = "CTRL" } },
  { key = "c",          mods = "LEADER",      action = act.ActivateCopyMode },
  { key = "phys:Space", mods = "LEADER",      action = act.ActivateCommandPalette },
  { key = "h",          mods = "LEADER|CTRL", action = act.SendKey { key = "h", mods = "CTRL" } },
  -- { key = "j",          mods = "CTRL",      action = act.ActivatePaneDirection("Down") },
  -- { key = "k",          mods = "CTRL",      action = act.ActivatePaneDirection("Up") },
  -- { key = "l",          mods = "CTRL",      action = act.ActivatePaneDirection("Right") },
  --

  -- Pane keybindings
  { key = "-",          mods = "CTRL",        action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "|",          mods = "CTRL|SHIFT",  action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "h",          mods = "LEADER",      action = act.ActivatePaneDirection("Left") },
  { key = "j",          mods = "LEADER",      action = act.ActivatePaneDirection("Down") },
  { key = "k",          mods = "LEADER",      action = act.ActivatePaneDirection("Up") },
  { key = "l",          mods = "LEADER",      action = act.ActivatePaneDirection("Right") },
  { key = "q",          mods = "LEADER",      action = act.CloseCurrentPane { confirm = true } },
  { key = "z",          mods = "LEADER",      action = act.TogglePaneZoomState },
  { key = "o",          mods = "LEADER",      action = act.RotatePanes "Clockwise" },
  -- We can make separate keybindings for resizing panes
  -- But Wezterm offers custom "mode" in the name of "KeyTable"
  { key = "r",          mods = "LEADER",      action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

  -- Tab keybindings
  { key = "t",          mods = "LEADER",      action = act.SpawnTab("CurrentPaneDomain") },
  { key = "[",          mods = "CTRL",        action = act.ActivateTabRelative(-1) },
  { key = "]",          mods = "CTRL",        action = act.ActivateTabRelative(1) },
  { key = "n",          mods = "LEADER",      action = act.ShowTabNavigator },
  {
    key = "e",
    mods = "LEADER",
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Renaming Tab Title...:" },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end)
    }
  },
  -- Key table for moving tabs around
  { key = "m", mods = "LEADER",       action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },
  -- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
  { key = "{", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
  { key = "}", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },

  -- Lastly, workspace
  { key = "w", mods = "LEADER",       action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },


  -- full screen
  { key = "f", mods = "LEADER",       action = act.ToggleFullScreen },

}

return config
