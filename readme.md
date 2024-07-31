# Advanced spritesheet exporter for Aseprite

This extension adds a more sophisticated spritesheet export command to Aseprite.

## Installation

To install, go to Aseprite's Settings -> Extensions -> Add Extension, and select advanced-spritesheet-export.aseprite-extension

## Features

* Choose which layers to export, regardless of visibility.
* Export groups as a single sprite.

## Usage

* All layers are exported by default. To ignore the active layer or group, select Layer -> Advanced Export -> Toggle Ignore. (default keyboard shortcut: Ctrl+Alt+I)
* To export a layer group as a single sprite, select Layer -> Advanced Export -> Toggle Merge Group. (default keyboard shortcut: Ctrl+Alt+M)
* Invoke the tool via File -> Export -> Export Sprite Sheet (Advanced). (default keyboard shortcut: Ctrl+Alt+E)

## Additional Notes

* Ignored layers always take precedence over merging; if a sublayer in a group is ignored, it will not be merged into the final sprite.
* Toggling the advanced export settings on a layer will modify the layer colors. The extension will attempt to detect and preserve user-colored layers. If you happen to use one of the exact colors we have chosen, this will fail. We have chosen odd alpha values to reduce the likelihood of a false negative, but if you are using layer colors extensively, this extension may not work well for you.
* To force a layer's color to be controlled by the extension, simply reset the layer's color to all 0 values. (red, green, blue, and alpha should all be 0) You may need to toggle the export settings of a parent layer or create a new layer before the changes take effect.


## Copyright Notice

Copyright 2024 Anna Wiggins

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.