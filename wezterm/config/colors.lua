local wezterm = require('wezterm')
local function scheme_for_appearance(appearance)
   if appearance:find('Dark') then
      return 'Catppuccin Mocha (Gogh)'
   else
      return 'Nord (Gogh)'
   end
end

return {
   color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
}
