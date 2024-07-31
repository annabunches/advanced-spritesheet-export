-- Functions for modifying a sprite

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

local export = {
    DeleteLayers = DeleteLayers,
    FlattenLayers = FlattenLayers,
    RevealLayers = RevealLayers,
}
return export