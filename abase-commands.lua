-- New commands to be executed via Aseprite menus / keyboard shortcuts
local sprt = require "abase-sprite"

local BASE_COLOR = Color {
    r = 0,
    g = 0,
    b = 0,
    a = 0
}
local IGNORE_COLOR = Color {
    gray = 100
}
local IGNORE_SUBCOLOR = Color {
    gray = 150
}
local MERGE_COLOR = Color {
    r = 200,
    g = 200,
    b = 0
}
local MERGE_SUBCOLOR = Color {
    r = 200,
    g = 200,
    b = 128
}

-- set the color of a layer and its sublayers
local function setColor(layer, subColor)
    if (layer.properties(extKey).ignored) then
        layer.color = IGNORE_COLOR
        subColor = IGNORE_SUBCOLOR
    elseif subColor == IGNORE_SUBCOLOR then
        layer.color = subColor
    elseif (layer.properties(extKey).exportedAsSprite) then
        layer.color = MERGE_COLOR
        subColor = MERGE_SUBCOLOR
    elseif subColor == MERGE_SUBCOLOR then
        layer.color = subColor
    else
        layer.color = BASE_COLOR
    end

    if (layer.isGroup) then
        for i, sublayer in ipairs(layer.layers) do
            setColor(sublayer, subColor)
        end
    end
end

local function ExportSpritesheetAdvanced()
    if not app.sprite then
        return app.alert "Must have a sprite open to export."
    end

    local spr = Sprite(app.sprite)

    sprt.deleteLayers(spr, spr.layers)
    sprt.flattenLayers(spr.layers)
    sprt.revealLayers(spr.layers)

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
    setColor(layer)
end

local function ToggleExportAsSprite()
    local layer = app.layer
    if (layer.properties(extKey).exportedAsSprite) then
        layer.properties(extKey).exportedAsSprite = false
    else
        layer.properties(extKey).exportedAsSprite = true
    end
    setColor(layer)
end

local export = {
    ExportSpritesheetAdvanced = ExportSpritesheetAdvanced,
    ToggleIgnore = ToggleIgnore,
    ToggleExportAsSprite = ToggleExportAsSprite
}
return export
