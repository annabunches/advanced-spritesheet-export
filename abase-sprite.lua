-- Functions for modifying a sprite

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

-- Deletes any layers with the 'ignored' property.
local function deleteLayers(spr, layers)
    for i, layer in ipairs(layers) do
        if layer.properties(extKey).ignored then
            spr:deleteLayer(layer)
        elseif layer.isGroup then
            deleteLayers(spr, layer.layers)
        end
    end
end

-- Flattens any layers that have the 'exportedAsSprite' property.
-- Should be called after deleteLayers.
local function flattenLayers(layers)
    for i, layer in ipairs(layers) do
        if not layer.isGroup then
            goto continue
        end

        if layer.properties(extKey).exportedAsSprite then
            app.range.layers = {layer}
            app.command.FlattenLayers(false)
        else
            -- recurse
            flattenLayers(layer.layers)
        end

        ::continue::
    end
end

-- Makes all layers visible.
-- This should be called after deleteLayers and flattenLayers
local function revealLayers(layers)
    for i, layer in ipairs(layers) do
        if layer.isGroup then
            revealLayers(layer.layers)
        end

        if not layer.isVisible then
            layer.isVisible = true
        end
    end
end

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



local export = {
    deleteLayers = deleteLayers,
    flattenLayers = flattenLayers,
    revealLayers = revealLayers,
    setColor = setColor,
}
return export