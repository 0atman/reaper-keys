---
layout: default
title: Advanced Configuration
nav_order: 3
parent: Configuration
---

## Advanced Configuration

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
