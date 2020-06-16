---
title: Action Types
layout: default
---

## Action Types

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">action type</th>
<th scope="col" class="org-left">description</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">`command`</td>
<td class="org-left">A generic command. Does not compose, accessible from every mode.</td>
</tr>


<tr>
<td class="org-left">`timeline_motion`</td>
<td class="org-left">Moves the edit cursor somewhere on the timeline.</td>
</tr>


<tr>
<td class="org-left">`timeline_selector`</td>
<td class="org-left">Sets the timeline selection .</td>
</tr>


<tr>
<td class="org-left">`timeline_operator`</td>
<td class="org-left">An actions that operates on a timeline selection.</td>
</tr>


<tr>
<td class="org-left">`track_motion`</td>
<td class="org-left">Changes the selected track.</td>
</tr>


<tr>
<td class="org-left">`track_selector`</td>
<td class="org-left">Selects a track or multiple tracks.</td>
</tr>


<tr>
<td class="org-left">`track_operator`</td>
<td class="org-left">An actions that operaes on a selection of tracks.</td>
</tr>


<tr>
<td class="org-left">`visual_timeline_command`</td>
<td class="org-left">A command only available in visual timeline mode.</td>
</tr>


<tr>
<td class="org-left">`visual_track_command`</td>
<td class="org-left">A command only available in visual track mode</td>
</tr>


<tr>
<td class="org-left">`meta_command`</td>
<td class="org-left">A special command handled by the reaper-keys engine.</td>
</tr>
</tbody>
</table>


<a id="org75c1f70"></a>
