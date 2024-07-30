-- Functions for modifying a sprite
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

local export = {
    deleteLayers = deleteLayers,
    flattenLayers = flattenLayers,
    revealLayers = revealLayers
}
return export