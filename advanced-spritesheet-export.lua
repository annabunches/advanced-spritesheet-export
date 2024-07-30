extKey = "annabunches/abase" -- this must come before we require 'abase-commands'

local cmd = require "abase-commands"

function init(plugin)
  plugin:newCommand{
    id="AnnabunchesASEExportSpritesheetAdvanced",
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

  plugin:newCommand{
    id="AnnabunchesASEToggleIgnoreLayer",
    title="Ignore on Export",
    group="layer_popup_merge",
    onclick=function()
      cmd.ToggleIgnore()
    end
  }

  plugin:newCommand{
    id="AnnabunchesASEToggleExportAsSprite",
    title="Export as Sprite",
    group="layer_popup_merge",
    onclick=function()
      cmd.ToggleExportAsSprite()
    end,
    onnenabled=function()
      return app.layer.isGroup
    end
  }
end