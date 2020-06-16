---
title: Bindings
layout: default
parent: Configuration
---

You may define or change key sequences for a specific context (in <main.lua> or <midi.lua>) or for all contexts (in <global.lua>).

I organize the entries in these files by `action type`.

Here is an example snippet that declares some bindings in the `timeline_operators`
action type section.

```lua
timeline_operator = {
    ["c"] = "Change",
    ["t"] = "PlayAndLoop",
    ["d"] = "CutItems",
    ["y"] = "CopyItems",
  },
```  

Actions may also be put into folders. To create a folder,  follow this format:

``` lua
["<C-c>"] = "ToggleFloatingWindows",
["<SPC>"] = { "+leader commands", {
  ["<SPC>"] = "ShowActionList",
  ["h"] = "ShowReaperKeysHelp",
  ["r"] = {"+regions", {
              ["d"] = "RemoveRegion",
  }},
}}, -- be sure to close the folder
``` 
