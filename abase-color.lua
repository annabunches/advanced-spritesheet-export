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

local function safeSetColor(layer, color)
    pixelValue = layer.color.rgbaPixel
--[[     print("safeSetColor: " .. pixelValue)
    print(BASE_COLOR.rgbaPixel)
    print(IGNORE_COLOR.rgbaPixel)
    print(IGNORE_SUBCOLOR.rgbaPixel)
    print(MERGE_COLOR.rgbaPixel)
    print(MERGE_SUBCOLOR.rgbaPixel) ]]
    if (pixelValue ~= BASE_COLOR.rgbaPixel and
        pixelValue ~= IGNORE_COLOR.rgbaPixel and
        pixelValue ~= IGNORE_SUBCOLOR.rgbaPixel and
        pixelValue ~= MERGE_COLOR.rgbaPixel and
        pixelValue ~= MERGE_SUBCOLOR.rgbaPixel) then
--[[             print("DEBUG: not setting color")
 ]]            return
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
    SetColor = SetColor,
    SetColorFromRoot = SetColorFromRoot,
}
return export