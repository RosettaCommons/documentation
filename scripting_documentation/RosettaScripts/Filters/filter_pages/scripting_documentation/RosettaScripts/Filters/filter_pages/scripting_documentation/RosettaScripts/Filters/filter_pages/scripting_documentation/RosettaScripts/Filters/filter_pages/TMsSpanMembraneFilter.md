# TMsSpanMembraneFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## TMsSpanMembraneFilter

iterates over all spans requried by the AddMembrane mover (what the user required to be spanning the membrane),
and checks if they all span the membrane. 
to be considered as spanning the membrane, the span has to pass these tests:
1. distance on Z axis between end and starting residues Ca is equal or greater than min_distance
2. both starting and ending residues Ca Z coordinate must be within required_dist of the membrane edge (-15, 15 by default)
3. the span orientation is as required in AddMembrane
4. no residues that are not in the required spans (plus the flank on either side) are NOT in the membrane

```
<TMsSpanMembrane name="(& string)" required_distance="(10 &real)" min_distance="(20 &real)" flank="(1 &int|)"/>
```

- required_distance - minimal required distance on Z axis between start and end residue for each span
- min_distance - minimal Z axis distance required between start and end residue Ca on every span
- flank - the number of residues on the flanks of each span that are allowed to be in the membrane

## See also

* [[ResidueLipophilicity]]
