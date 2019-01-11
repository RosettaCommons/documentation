# SlideTogether
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SlideTogether

```xml
<SlideTogether name="&string" chains="&string"/>
```

The initial translation and rotation may move the ligand to a spot too far away from the protein for docking. Thus, after an initial low resolution translation and rotation of the ligand it is necessary to move the small molecule and protein into close proximity. If this is not done then high resolution docking will be useless. Simply specify which chain to move. This mover then moves the small molecule toward the protein 2 angstroms at a time until the two clash (evidenced by repulsive score). It then backs up the small molecule. This is repeated with decreasing step sizes, 1A, 0.5A, 0.25A, 0.125A.


##See Also

* [[TransformMover]]: Designed to replace the TranslateMover, RotateMover, and SlideTogetherMover
* [[TranslateMover]]
* [[RotateMover]]
* [[I want to do x]]: Guide to choosing a mover
