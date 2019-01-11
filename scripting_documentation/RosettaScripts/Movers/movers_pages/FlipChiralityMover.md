# FlipChirality
Page created by Parisa Hosseinzadeh (parisah@uw.edu).  Last modified 16 June 2016.
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FlipChirality

Mirrors a pose (or selected parts of a pose). The residues are mirrored using with respect to a plane that can be defined by the user. For example L-amino acids will be changed to their D-counterparts, meaning that phi and psi angles will be mirrored and the name will change.

```xml
<FlipChirality name="(&string)" residue_selector="(&selector_name)" normalx="(0.0 &real)" normaly="(0.0 &real)" normalz="(0.0 &real)" centerx="(0.0 &real)" centery="(0.0 &real)" centerz="(0.0 &real)"/>
```

If user provides normal vector values (<b>normalx, normaly, normalz</b>) and center coordinates (<b>centerx, centery, centerz</b>), then the pose is going to be mirrored against the plane that is uniquely defined by these two. The default value for normal vector is (0,0,1) and the default center point is "center of mass" of the pose. User can defined either of the two but for each, all three components should be specified. If no residue_selector is provided, the whole pose will be mirrored.

Example: This scripts mirrors chain B in a pose using default settings:

```xml
<RESIDUE_SELECTORS>
  <Chain name="chainB" chains="2"/>
</RESIDUE_SELECTORS>
<MOVERS>
  <FlipChiralityMover name="mirror" residue_selector="chainB"/>
</MOVERS>
<PROTOCOLS>
   <Add mover="mirror"/> 
</PROTOCOLS>
```


