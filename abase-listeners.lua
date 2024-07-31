local c = require "abase-color"

-- recolors all layers in the current sprite
local function RecolorLayers()
  for i, layer in ipairs(app.sprite.layers) do
    c.SetColor(layer)
  end
end

local export = {
  RecolorLayers = RecolorLayers,
}
return export