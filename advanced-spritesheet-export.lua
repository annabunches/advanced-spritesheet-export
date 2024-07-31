extKey = "annabunches/abase" -- this must come before we require 'abase-commands'

local cmd = require "abase-commands"
local listeners = require "abase-listeners"

function init(plugin)
  plugin:newCommand{
    id="ABASEExportSpritesheetAdvanced",
    title="Export Spritesheet (Advanced)",
    group="file_export_1",
    onclick=function()
      cmd.ExportSpritesheetAdvanced()
    end,
    onenabled=function()
      return app.activeSprite ~= nil
    end
  }

  plugin:newMenuSeparator{
    group="layer_popup_merge"
  }

  plugin:newMenuSeparator{
    group="layer_merge"
  }

  plugin:newMenuGroup{
    id="abase_layer_settings",
    title="Advanced Export",
    group="layer_merge",
  }

  plugin:newMenuGroup{
    id="abase_layer_settings_popup",
    title="Advanced Export",
    group="layer_popup_merge",
  }

  plugin:newCommand{
    id="ABASEToggleIgnoreLayer",
    title="Toggle Ignore",
    group="abase_layer_settings",
    onclick=function()
      cmd.ToggleIgnore()
    end
  }

  plugin:newCommand{
    id="ABASEToggleIgnoreLayerPopup",
    title="Toggle Ignore",
    group="abase_layer_settings_popup",
    onclick=function()
      cmd.ToggleIgnore()
    end
  }

  plugin:newCommand{
    id="ABASEToggleExportAsSprite",
    title="Toggle Merge Group",
    group="abase_layer_settings",
    onclick=function()
      if app.layer.isGroup then
        cmd.ToggleExportAsSprite()
      end
    end,
    onenabled=function()
      return app.layer.isGroup
    end
  }

  plugin:newCommand{
    id="ABASEToggleExportAsSpritePopup",
    title="Toggle Merge Group",
    group="abase_layer_settings_popup",
    onclick=function()
      if app.layer.isGroup then
        cmd.ToggleExportAsSprite()
      end
    end,
    onenabled=function()
      return app.layer.isGroup
    end
  }

  app.events:on(
    "aftercommand",
    function(ev)
      if (ev.name == "NewLayer") then
        listeners.RecolorLayers()
      end
    end
  )
end