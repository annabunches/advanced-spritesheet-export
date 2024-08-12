-- New commands to be executed via Aseprite menus / keyboard shortcuts
local l = require "abase-layer"
local c = require "abase-color"
local p = require "abase-properties"

local function ExportSpritesheetAdvanced()
    if not app.sprite then
        return app.alert "Must have a sprite open to export."
    end

    local spr = Sprite(app.sprite)

    l.RevealLayers(spr.layers)
    l.DeleteLayers(spr, spr.layers)
    l.FlattenLayers(spr.layers)

    app.command.ExportSpriteSheet {
        splitLayers = true
    }

    spr:close()
end

-- Toggle ignore for all selected layers
local function ToggleIgnore()
    -- Determine whether we are setting or clearing the flag
    local ignore = false
    for _, layer in ipairs(app.range.layers) do
        if not p.IsIgnored(layer) then
            ignore = true
        end
    end

    for _, layer in ipairs(app.range.layers) do
        p.SetIgnored(layer, ignore)
        c.SetColorFromRoot(layer)
    end
end

-- Toggle Merge on Export for all selected group layers
local function ToggleExportAsSprite()
    -- Determine whether we are setting or clearing the flag
    local merge = false
    for _, layer in ipairs(app.range.layers) do
        if layer.isGroup and not p.IsMerged(layer) then
            merge = true
        end
    end

    for _, layer in ipairs(app.range.layers) do
        p.SetMerged(layer, merge)
        c.SetColorFromRoot(layer)
    end
end

local export = {
    ExportSpritesheetAdvanced = ExportSpritesheetAdvanced,
    ToggleIgnore = ToggleIgnore,
    ToggleExportAsSprite = ToggleExportAsSprite
}
return export
