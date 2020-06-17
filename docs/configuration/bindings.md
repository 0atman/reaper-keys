---
layout: default
title: Bindings
nav_order: 1
parent: Configuration
---

# Bindings

    ├── definitions
        ├── global.lua
        ├── main.lua
        └── midi.lua

The `global`, `main`, and `midi` files contain binding definitions (i.e. 'key sequence -> action' mappings)

You may define or change key sequences for a specific context (in `main` or `midi`) or for all contexts (in `global`).

The entries in these files are organized by `action type`.

Here is an example snippet that declares some bindings in the `timeline_operators`
action type section.

```lua
timeline_operator = {
    ["r"] = "Record",
    ["t"] = "PlayAndLoop",
  },
```  

Actions may also be put into folders. To create a folder,  follow this format:

``` lua
command = {
  ["<SPC>"] = { "+leader commands", {
    ["<SPC>"] = "ShowActionList",
    ["h"] = "ShowReaperKeysHelp",
    ["m"] = { "+midi", {
                ["x"] = "CloseWindow",
                ["g"] = "SetMidiGridDivision",
                ["q"] = "Quantize",
                [","] = {"+options", {
                            ["g"] = "ToggleMidiEditorUsesMainGridDivision",
                            ["s"] = "ToggleMidiSnap",

                }},
    }},
}
``` 