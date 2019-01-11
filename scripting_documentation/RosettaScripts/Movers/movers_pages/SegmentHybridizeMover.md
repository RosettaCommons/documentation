# SegmentHybridize
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SegmentHybridize

SegmentHybridize takes the principle from the cartesian hybridize protocol to close loops. it will align fragments to the broken section until the ends are close enough (as defined through rms\_frags) to use the [[cartesian minimizer|Glossary#cartesian-minimization]] for closure. The principle is to allow small breaks to close one big gap, with the idea of closing the small ones through minimization. Can be used for loop closure or grafting (still very experimental).

```xml
<SegmentHybridizer name="hyb" frag_big="3" rms_frags="0.5" nfrags="2000" frag_tries="2000" auto_mm="1" all_movable="0" extra_min="1" mc_cycles="1000" use_frags="1" use_seq="1">
               <Span begin="6B" end="15B" extend_outside="2" extend_inside="1"/>

</SegmentHybridizer> 
```

-   frag\_big: what fragment size should be used to close the gaps?
-   rms\_frags: at what size of a break to use the cartesian minimizer to close the gap
-   frag\_tries: how many fragments should be tried?
-   auto\_mm: should the movemap (defines what should be allowed to minimize) be set automatically?
-   all\_movable: everything in the last chain will be minimized (target would be the first chain)
-   extra\_min: extra minimization?
-   use\_frags: use fragments or just the minimizer
-   use\_seq: how to pick the fragments, as in either only secondary structure dependent or secondary structure and sequence dependent (if 1)
-   span defines the loop of interest, can be automated or everything can be used and then it will just try to fix every possible gap
-   extend\_outside: how far to go outside of the loop to allow fragement hybridization for loop closure (note, if you go too far out it might not close the loop...)
-   to what residue inside the loop should the fragment be aligned to?


##See Also

* [[LoopModelerMover]]
* [[RosettaScriptsLoopModeling]]: Guide to loop modeling in RosettaScripts
* [[Loop file format|loops-file]]
* [[Minimization overview]]
