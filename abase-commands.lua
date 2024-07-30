-- New commands to be executed via Aseprite menus / keyboard shortcuts
local layerUtils = require "abase-layer"

local function ExportSpritesheetAdvanced()
    if not app.sprite then
        return app.alert "Must have a sprite open to export."
    end

    local spr = Sprite(app.sprite)

    layerUtils.DeleteLayers(spr, spr.layers)
    layerUtils.FlattenLayers(spr.layers)
    layerUtils.RevealLayers(spr.layers)

    app.command.ExportSpriteSheet {
        splitLayers = true
    }

    spr:close()
end

local function ToggleIgnore()
    local layer = app.layer
    if (layer.properties(extKey).ignored) then
        layer.properties(extKey).ignored = false
    else
        layer.properties(extKey).ignored = true
    end
    layerUtils.SetColorFromRoot(layer)
end

local function ToggleExportAsSprite()
    local layer = app.layer
    if (layer.properties(extKey).exportedAsSprite) then
        layer.properties(extKey).exportedAsSprite = false
    else
        layer.properties(extKey).exportedAsSprite = true
    end
    layerUtils.SetColorFromRoot(layer)
end

local export = {
    ExportSpritesheetAdvanced = ExportSpritesheetAdvanced,
    ToggleIgnore = ToggleIgnore,
    ToggleExportAsSprite = ToggleExportAsSprite
}
return export
