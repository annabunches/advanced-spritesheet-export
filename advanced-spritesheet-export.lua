local extKey = "annabunches/AtlasExporter"

function init(plugin)
  plugin:newCommand{
    id="AnnabunchesASEExportSpritesheetAdvanced",
    title="Export Spritesheet (Advanced)",
    group="file_export",
    onclick=exportSpritesheetAdvanced
  }

  plugin:newCommand{
    id="AnnabunchesASEToggleIgnoreLayer",
    title="Ignore on Export",
    group="layer_popup_menu",
    onclick=toggleIgnore
  }

  plugin:newCommand{
    id="AnnabunchesASEToggleExportAsSprite",
    title="Export as Sprite",
    group="layer_popup_menu",
    onclick=toggleExportAsSprite
  }
end

local function revealLayers(layers)
  for i, layer in ipairs(layers) do
    if layer.isGroup then
      revealLayers(layer.layers)
    end

    if not layer.isVisible then
      layer.isVisible = true
      layer.properties(extKey).revealed = true
    end
  end
end

local function restoreLayers(layers)
  for i, layer in ipairs(layers) do
    if layer.isGroup then
      restoreLayers(layer.layers)
    end

    if layer.properties(extKey).revealed then
      layer.isVisible = false
--      layer.properties(extKey).revealed = nil
    end
  end
end

local function deleteLayers(sprite, layers)
  for i, layer in ipairs(layers) do
    if layer.name:find("%+i") then
      sprite:deleteLayer(layer)
    elseif layer.isGroup then
      deleteLayers(sprite, layer.layers)
    end
  end
end

local function flattenLayers(layers)
  for i, layer in ipairs(layers) do
    if not layer.isGroup then
      goto continue
    end

    -- Layers "tagged" with +f get flattened
    if layer.name:find("%+f") then
      app.range.layers = { layer }
      app.command.FlattenLayers(false)
    else
      -- recurse
      flattenLayers(layer.layers)
    end

    ::continue::
  end
end

local function exportSpritesheetAdvanced()
  local sprite = app.activeSprite
  if not sprite then
    return app.alert "Must have a sprite open to export."
  end

  app.transaction(function()
    deleteLayers(sprite, sprite.layers)
    flattenLayers(sprite.layers)
    revealLayers(sprite.layers)
  end)
  app.command.ExportSpriteSheet {
    splitLayers=true,
  }
  restoreLayers(sprite.layers)
  app.undo()
end

main()
