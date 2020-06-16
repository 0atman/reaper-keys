---
layout: default
title: Configuration
nav_order: 5
has_toc: true
---

# Configuration
{: .no_toc}
1. TOC
{:toc}

## How To Configure
All you need to configure Reaper-Keys is in the `definitions` directory. There are a couple files in there.

    ├── definitions
        ├── actions.lua
        ├── config.lua
        ├── global.lua
        ├── main.lua
        ├── midi.lua
        └── README.md
        
These files contain lua tables that may be altered to change or add key bindings, actions, or tweak reaper-keys behaviour. 

### Bindings
The `global`, `main`, and `midi` files contain binding definitions (i.e. 'key sequence -> action' mappings)

You may define or change key sequences for a specific context (in `main` or `midi`) or for all contexts (in `global`).

The entries in these files are organized by `action type`.

Here is an example snippet that declares some bindings in the `timeline_operators`
action type section.

```lua
timeline_operator = {
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
}}, 
``` 

### Actions
The `actions` file contains reaper-keys action definitions.

If a reaper-keys action does not exist for a reaper command you want to create a binding for, you may add an entry into this file. You just need to come up with a name for the action and get it's `Command Id` (available in reapers action list).

Here is an example entry that creates the reaper-keys action `SelectFoldersChildren` that contains the id of the SWS command to select a folders children.

``` lua
SelectFoldersChildren = "_SWS_SELCHILDREN2",
```

Reaper-keys actions may also be a sequence of command id's, reaper-key
action names, provided 'lib' functions, provided 'custom' functions, or any combination of them. 

Here are more examples of action definitions.

``` lua
SelectOnlyCurrentTrack = custom.select.onlyCurrentTrack,
UnselectItems = 40289,
UnselectEnvelopePoints = 40331,
UnselectAllEvents = {40214, midiCommand=true},
ResetSelection = {"SelectOnlyCurrentTrack", "UnselectItems", "UnselectEnvelopePoints", "UnselectAllEvents"},
Stop = 40667,
SetModeNormal = lib.setModeNormal,
SetRecordModeNormal = 40252,
Reset = {"Stop", "SetModeNormal", "SetRecordModeNormal", "ResetSelection"},
```

#### Action Options
You may have noticed that this action had an option set:
``` lua
UnselectAllEvents = {40214, midiCommand=true},
```

There are various other options that tweak the actions behaviour. 

| Option                | Use                                                                                                  |
| ------                | ---                                                                                                  |
| repetitions           | Specifies the number of times to run the action                                                      |
| midiCommand           | Indicates that the action id is from REAPERs 'MidiEditor' section                                    |
| setTimeSelection      | Used with timeline operator actions to set the timeline selection to the preceding movement/selector |
| setTrackSelection     | Used with track operator actions to keep the preceding track movement/selector selection             |
| prefixRepetitionCount | Indicates a number may prefix the actions key binding which will indicate repetitions.               |


### Reaper-Keys Configuration
The `config` file has entries that tweak reaper-keys behaviour. One example is how verbose it's logging should be.


### Advanced Configuration

If you are interested in adding another mode or action type to reaper keys and
aren't scared of a bit of lua scripting, take a look at [sequence functions](file:///../internal/command/sequence_functions/) directory.

There you will find all the functions that execute composed actions (excluding
meta actions). There is a file for each context, and a section for each mode.

Here is an example entry that defines the sequence `'timeline_operator'
timeline_motion'`, with the accompanying 'glue' function that composes the actions.

``` lua
-- in global.lua
normal = {
  {
    { 'timeline_operator', 'timeline_motion' },
    function(timeline_operator, timeline_motion)
      -- check out this link for the reaper api definitions
      -- https://www.reaper.fm/sdk/reascript/reascripthelp.html
      -- this gets the current time selection
      local start_sel, end_sel = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
      -- runner provides utility functions to execute actions, and do other things
      runner.makeSelectionFromTimelineMotion(timeline_motion, 1)
      runner.runAction(timeline_operator)
      -- check if we were passed a table so we don't break when checking an option
      if type(timeline_operator) ~= 'table' or not timeline_operator['setTimeSelection'] then
        -- revert the time selection because we were not specified not to
        reaper.GetSet_LoopTimeRange(true, false, start_sel, end_sel, false)
      end
    end
  },
},
```

When a key binding sequence triggers the action, it will be passed the values of
the actions used to trigger it.

So in this case, if one types `tl`

Reaper keys will find the entries "PlayAndLoop" and "NextBeat" in it's search in the definitions.

``` lua
-- in definitoins/global.lua the
  timeline_operator = {
    ["t"] = "Play",
  },
  timeline_motion = {
    ["l"] = "NextBeat",
  },
```

And find the value of the action in actions.lua

``` lua
-- in definitions/actions.lua
PlayAndLoop = {"SetLoopSelectionToTimeSelection", "LoopStart", "TransportPlay", setTimeSelection=true},
NextBeat = 40841,
```

and execute the function with

``` lua
function({"SetLoopSelectionToTimeSelection", "LoopStart", "TransportPlay", setTimeSelection=true}, 40841)
```

Reaper keys prioritizes entries in order of  context, then index in the list.

It is enough to define an entry like the above, with a new action type or key
type sequence, to create a new action type.

To create a new mode, add an entry at the level of 'normal' in the example. Then
populate it with entries alike the above.
