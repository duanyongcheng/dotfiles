local wezterm = require('wezterm')

local config = {}
local function copy(tabel)
   for key, value in pairs(tabel) do
      config[key] = value
   end
end
copy(require('config.appearance'))
copy(require('config.keys'))
copy(require('config.colors'))
copy(require('config.font'))

return config
