local wezterm = require('wezterm')
local function scheme_for_appearance(appearance)
   if appearance:find('Dark') then
      return 'Catppuccin Frappe'
   else
      return 'Catppuccin Frappe'
   end
end

return {
   color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
}
