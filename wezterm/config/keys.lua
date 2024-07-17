local wezterm = require('wezterm')
local act = wezterm.action
return {
   -- Keys
   leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 },
   keys = {
      -- Send C-a when pressing C-a twice
      { key = 'a', mods = 'LEADER|CTRL', action = act.SendKey({ key = 'a', mods = 'CTRL' }) },
      { key = 'c', mods = 'CTRL|SHIFT', action = act.ActivateCopyMode },
      { key = 'phys:Space', mods = 'LEADER', action = act.ActivateCommandPalette },
      { key = 'h', mods = 'LEADER|CTRL', action = act.SendKey({ key = 'h', mods = 'CTRL' }) },
      -- { key = "j",          mods = "CTRL",      action = act.ActivatePaneDirection("Down") },
      -- { key = "k",          mods = "CTRL",      action = act.ActivatePaneDirection("Up") },
      -- { key = "l",          mods = "CTRL",      action = act.ActivatePaneDirection("Right") },
      --

      -- Pane keybindings
      { key = '-', mods = 'CTRL', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
      {
         key = '|',
         mods = 'CTRL|SHIFT',
         action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
      },
      { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection('Left') },
      { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection('Down') },
      { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection('Up') },
      { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection('Right') },
      { key = 'q', mods = 'LEADER', action = act.CloseCurrentPane({ confirm = true }) },
      { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
      { key = 'o', mods = 'LEADER', action = act.RotatePanes('Clockwise') },
      -- We can make separate keybindings for resizing panes
      -- But Wezterm offers custom "mode" in the name of "KeyTable"
      {
         key = 'r',
         mods = 'LEADER',
         action = act.ActivateKeyTable({ name = 'resize_pane', one_shot = false }),
      },

      -- Tab keybindings
      { key = 't', mods = 'LEADER', action = act.SpawnTab('CurrentPaneDomain') },
      { key = '[', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
      { key = ']', mods = 'CTRL', action = act.ActivateTabRelative(1) },
      { key = 'n', mods = 'LEADER', action = act.ShowTabNavigator },
      {
         key = 'e',
         mods = 'LEADER',
         action = act.PromptInputLine({
            description = wezterm.format({
               { Attribute = { Intensity = 'Bold' } },
               { Foreground = { AnsiColor = 'Fuchsia' } },
               { Text = 'Renaming Tab Title...:' },
            }),
            action = wezterm.action_callback(function(window, pane, line)
               if line then
                  window:active_tab():set_title(line)
               end
            end),
         }),
      },
      -- Key table for moving tabs around
      {
         key = 'm',
         mods = 'LEADER',
         action = act.ActivateKeyTable({ name = 'move_tab', one_shot = false }),
      },
      -- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
      { key = '{', mods = 'LEADER|SHIFT', action = act.MoveTabRelative(-1) },
      { key = '}', mods = 'LEADER|SHIFT', action = act.MoveTabRelative(1) },

      -- Lastly, workspace
      { key = 'w', mods = 'LEADER', action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }) },

      -- full screen
      { key = 'f', mods = 'LEADER', action = act.ToggleFullScreen },
      -- tmux
      {
         key = '1',
         mods = 'CMD',
         action = wezterm.action.Multiple({
            wezterm.action.SendKey({mods = 'CTRL', key = 'a'}),
            wezterm.action.SendKey({key = '1'}),
         }),
      },
      {
         key = '2',
         mods = 'CMD',
         action = wezterm.action.Multiple({
            wezterm.action.SendKey({mods = 'CTRL', key = 'a'}),
            wezterm.action.SendKey({key = '2'}),
         }),
      },
      {
         key = '3',
         mods = 'CMD',
         action = wezterm.action.Multiple({
            wezterm.action.SendKey({mods = 'CTRL', key = 'a'}),
            wezterm.action.SendKey({key = '3'}),
         }),
      },
      {
         key = '4',
         mods = 'CMD',
         action = wezterm.action.Multiple({
            wezterm.action.SendKey({mods = 'CTRL', key = 'a'}),
            wezterm.action.SendKey({key = '4'}),
         }),
      },
      {
         key = '5',
         mods = 'CMD',
         action = wezterm.action.Multiple({
            wezterm.action.SendKey({mods = 'CTRL', key = 'a'}),
            wezterm.action.SendKey({key = '5'}),
         }),
      },
      {
         key = '6',
         mods = 'CMD',
         action = wezterm.action.Multiple({
            wezterm.action.SendKey({mods = 'CTRL', key = 'a'}),
            wezterm.action.SendKey({key = '6'}),
         }),
      },
      {
         key = '7',
         mods = 'CMD',
         action = wezterm.action.Multiple({
            wezterm.action.SendKey({mods = 'CTRL', key = 'a'}),
            wezterm.action.SendKey({key = '7'}),
         }),
      },
      {
         key = '8',
         mods = 'CMD',
         action = wezterm.action.Multiple({
            wezterm.action.SendKey({mods = 'CTRL', key = 'a'}),
            wezterm.action.SendKey({key = '8'}),
         }),
      },
      {
         key = '9',
         mods = 'CMD',
         action = wezterm.action.Multiple({
            wezterm.action.SendKey({mods = 'CTRL', key = 'a'}),
            wezterm.action.SendKey({key = '9'}),
         }),
      },
   },
}
