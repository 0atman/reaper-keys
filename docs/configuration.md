---
layout: default
title: Configuration
nav_order: 5
has_children: true
---

# Configuration

All you need to configure Reaper-Keys is in `definitions` directory. There are a couple files in there:

    ├── definitions
        ├── actions.lua
        ├── config.lua
        ├── global.lua
        ├── main.lua
        ├── midi.lua
        └── README.md

## Bindings
The `global`, `main`, and `midi` files contain binding definitions (i.e. 'key sequence -> action' mappings)


## Actions
The `actions` file contains reaper-keys action definitions.

If a reaper-keys action does not exist for a reaper command you want to create a binding for, you may add an entry into this file. You just need to come up with a name for the action and get it's `Command Id` (available in reapers action list).

Here is an example entry that creates the reaper-keys action `SelectFoldersChildren` that contains the id of the SWS command to select a folders children.

``` lua
SelectFoldersChildren = "_SWS_SELCHILDREN2",
```

Reaper-keys actions may also be a sequence of command id's, reaper-key
action names, provided 'lib' functions, provided 'custom' functions, or any combination of them. 

Here is an example of a more complicated action definition, that makes use of the provided 'lib' as well as other reaper-keys actions.

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

## Action Options
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


## Config
The `config` file has entries that tweak reaper-keys behaviour. One example is how verbose it's logging should be.
