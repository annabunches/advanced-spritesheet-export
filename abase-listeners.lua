local sprt = require "abase-sprite"

-- recolors all layers in the current sprite
local function RecolorLayers()
  for i, layer in ipairs(app.sprite.layers) do
    sprt.SetColor(layer)
  end
end


local export = {
  RecolorLayers = RecolorLayers,
}
return export