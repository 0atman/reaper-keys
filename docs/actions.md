---
layout: default
title: Actions
nav_order: 1
has_children: true
---

## Actions

The available actions for bindings are in the <actions.lua> file.

If an action does not exist for a command you want to create a binding for, you
may add an entry into <actions.lua> You just need to come up with a name for the
action and get it's `Command Id` ( available in reapers action list).

Here is an example entry:

    ``` lua
    SelectFoldersChildren = "_SWS_SELCHILDREN2",
    ```

Reaper-keys actions may also be a sequence of command id's, reaper-key
action names, internal 'lib' or 'util' functions, or any combination of them. They may
also have additional options. So

Here is an example of a more complicated action definition, that makes use of
previous ones, and makes use of the repetitions option.


``` lua
Stop = 40667,
SetModeNormal = lib.setModeToNormal,
Reset = {"Stop", "SetModeNormal"},
{% raw %}
Reset4TimesAndPlayForSomeReason = {{"Reset", repetitions=4}, "TransportPlay"}
{% endraw %}
```

The available options are:

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">option</th>
<th scope="col" class="org-left">use</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">repetitions</td>
<td class="org-left">specifies the number of times to run the action</td>
</tr>


<tr>
<td class="org-left">midiCommand</td>
<td class="org-left">indicates that the action id is from REAPERs 'MidiEditor' section</td>
</tr>


<tr>
<td class="org-left">setTimeSelection</td>
<td class="org-left">used with timeline operator actions to set the timeline selection to the preceding movement/selector</td>
</tr>


<tr>
<td class="org-left">setTrackSelection</td>
<td class="org-left">used with track operator actions to keep the preceding track movement/selector selection</td>
</tr>
</tbody>
</table>


<a id="orgaffcd37"></a>
