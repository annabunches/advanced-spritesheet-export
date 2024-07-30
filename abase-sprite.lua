-- Functions for modifying a sprite

local BASE_COLOR = Color {
    r = 0,
    g = 0,
    b = 0,
    a = 0,
}
local IGNORE_COLOR = Color {
    gray = 100,
    alpha = 254,
}
local IGNORE_SUBCOLOR = Color {
    gray = 150,
    alpha = 254,
}
local MERGE_COLOR = Color {
    r = 200,
    g = 200,
    b = 0,
    a = 254,
}
local MERGE_SUBCOLOR = Color {
    r = 200,
    g = 200,
    b = 128,
    a = 254,
}

-- Deletes any layers with the 'ignored' property.
local function DeleteLayers(spr, layers)
    for _, layer in ipairs(layers) do
        if layer.properties(extKey).ignored then
            spr:deleteLayer(layer)
        elseif layer.isGroup then
            DeleteLayers(spr, layer.layers)
        end
    end
end

-- Flattens any layers that have the 'exportedAsSprite' property.
-- Should be called after deleteLayers.
local function FlattenLayers(layers)
    for _, layer in ipairs(layers) do
        if not layer.isGroup then
            goto continue
        end

        if layer.properties(extKey).exportedAsSprite then
            app.range.layers = {layer}
            app.command.FlattenLayers(false)
        else
            -- recurse
            FlattenLayers(layer.layers)
        end

        ::continue::
    end
end

-- Makes all layers visible.
-- This should be called after deleteLayers and flattenLayers
local function RevealLayers(layers)
    for _, layer in ipairs(layers) do
        if layer.isGroup then
            RevealLayers(layer.layers)
        end

        if not layer.isVisible then
            layer.isVisible = true
        end
    end
end

local function safeSetColor(layer, color)
    pixelValue = layer.color.rgbaPixel

    if (pixelValue ~= BASE_COLOR.rgbaPixel and
        pixelValue ~= IGNORE_COLOR.rgbaPixel and
        pixelValue ~= IGNORE_SUBCOLOR.rgbaPixel and
        pixelValue ~= MERGE_COLOR.rgbaPixel and
        pixelValue ~= MERGE_SUBCOLOR.rgbaPixel) then
            print("DEBUG: not setting color")
            return
    end
    layer.color = color
end

-- set the color of a layer and its sublayers based on the extension properties
local function SetColor(layer, subColor)
    if (layer.properties(extKey).ignored) then
        safeSetColor(layer, IGNORE_COLOR)
        subColor = IGNORE_SUBCOLOR
    elseif subColor == IGNORE_SUBCOLOR then
        safeSetColor(layer, subColor)
    elseif (layer.properties(extKey).exportedAsSprite) then
        safeSetColor(layer, MERGE_COLOR)
        subColor = MERGE_SUBCOLOR
    elseif subColor == MERGE_SUBCOLOR then
        safeSetColor(layer, subColor)
    else
        safeSetColor(layer, BASE_COLOR)
    end

    if (layer.isGroup) then
        for i, sublayer in ipairs(layer.layers) do
            SetColor(sublayer, subColor)
        end
    end
end

-- Find the root of the layer stack, then set colors appropriately
-- for all children
local function SetColorFromRoot(layer)
    -- The standard Lua `if table["field"] == nil` throws an error in Aseprite.
    -- So we just check for the parent Layer being equal to the sprite.
    if layer.parent == layer.sprite then
        SetColor(layer)
    else
        SetColorFromRoot(layer.parent)
    end
end

local export = {
    DeleteLayers = DeleteLayers,
    FlattenLayers = FlattenLayers,
    RevealLayers = RevealLayers,
    SetColor = SetColor,
    SetColorFromRoot = SetColorFromRoot,
}
return export