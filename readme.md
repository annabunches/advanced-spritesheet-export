# Advanced spritesheet exporter for Aseprite

This extension adds a more sophisticated spritesheet export command to Aseprite.

## Installation

To install, go to Aseprite's Settings -> Extensions -> Add Extension, and select advanced-spritesheet-export.aseprite-extension

## Features

* Choose which layers to export, regardless of visibility.
* Export groups as a single sprite.

## Usage

* All layers are exported by default. To ignore a layer or group, select Layer -> Advanced Export -> Toggle Ignore.
* To export a layer group as a single sprite, select Layer -> Advanced Export -> Toggle Merge Group.
* Invoke the tool via File -> Export -> Export Sprite Sheet (Advanced).

## Additional Notes

* Toggling the advanced export settings on a layer will modify the layer colors. If you are using layer colors for other purposes, this extension will not work well for you. (This may be configurable in a future update)
* Ignored layers always take precedence over merging; if a sublayer in a group is ignored, it will not be merged into the final sprite.


## Copyright Notice

Copyright 2024 Anna Wiggins

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.