extKey = "annabunches/abase" -- this must come before we require 'abase-commands'

local cmd = require "abase-commands"

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
      cmd.ToggleExportAsSprite()
    end,
    onnenabled=function()
      return app.layer.isGroup
    end
  }

  plugin:newCommand{
    id="ABASEToggleExportAsSpritePopup",
    title="Toggle Merge Group",
    group="abase_layer_settings_popup",
    onclick=function()
      cmd.ToggleExportAsSprite()
    end,
    onnenabled=function()
      return app.layer.isGroup
    end
  }
end