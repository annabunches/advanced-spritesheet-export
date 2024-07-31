-- New commands to be executed via Aseprite menus / keyboard shortcuts
local layerUtils = require "abase-layer"
local colorUtils = require "abase-color"

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

local function toggleIgnoreLayer(layer)
    if (layer.properties(extKey).ignored) then
        layer.properties(extKey).ignored = false
    else
        layer.properties(extKey).ignored = true
    end
    colorUtils.SetColorFromRoot(layer)
end

-- Toggle ignore for all selected layers
-- TODO: should this behavior change when selected layers start with mixed state?
local function ToggleIgnore()
    for _, layer in ipairs(app.range.layers) do
        toggleIgnoreLayer(layer)
    end
end

local function toggleExportAsSpriteLayer(layer)
    if not layer.isGroup then return end

    if (layer.properties(extKey).exportedAsSprite) then
        layer.properties(extKey).exportedAsSprite = false
    else
        layer.properties(extKey).exportedAsSprite = true
    end
    colorUtils.SetColorFromRoot(layer)
end

-- Toggle Merge on Export for all selected group layers
-- TODO: should this behavior change when selected layers start with mixed state?
local function ToggleExportAsSprite()
    for _, layer in ipairs(app.range.layers) do
        toggleExportAsSpriteLayer(layer)
    end
end

local export = {
    ExportSpritesheetAdvanced = ExportSpritesheetAdvanced,
    ToggleIgnore = ToggleIgnore,
    ToggleExportAsSprite = ToggleExportAsSprite
}
return export
