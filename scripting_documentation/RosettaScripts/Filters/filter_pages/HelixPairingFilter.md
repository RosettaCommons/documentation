# HelixPairing
*Back to [[Filters|Filters-RosettaScripts]] page.*
## HelixPairing

Filter structures based on the geometry of helix pairings. Relating helix pairing geometry, this filter provides three parameters, dist, cross, and align, and the structures of which parameters are "below" thresholds are filtered.

```
<HelixPairing name=(&string) blueprint=(&string) helix_pairings=(&string)  dist=(15.0&Real) cross=(45.0&Real) align=(25.0&Real) bend=(20.0&Real) output_id=(1&Integer) output_type=(dist&string) />
```

-   helix\_pairings: helix pair is described by paired helix indices separated by "-" with orientations (P or A) after dot ".". Ex. 1-2.A means the pairing between the 1st and 2nd helices. The multiple pairings are concatenated with semicolon ";". Ex. 1-2.A;2-3.A;1-3.P
-   dist: distance between mid points of paired helices
-   cross: angle between helix vectors. The helix vector is between the centers of C- and N- terminal helix.
-   align: angle between helix vectors projected onto beta sheet that is defined by the strands immediately followed before the helices. This is calculated only when the strands exists within 6 residues before the helices.
-   bend: check bend of intra helix. This is not pairing related parameter, but for checking the intra helix bending. Basically, you don't need change this parameter.
-   output\_id: the helix pair id to be output in score file. e.g. 1 means 1-2.A in 1-2.A;2-3.P.
-   output\_type: parameter type to be output in score file, dist, cross, or align.
-   blueprint: By giving blueprint file, you can forcibly assign secondary structure. See [[rosettaremodel]] and [[Remodel]] for blueprint info.

## See also

* [[AbInitio Modeling|abinitio-relax]]
* [[Loop Modeling|loopmodel]]
* [[HelixKinkFilter]]
* [[SecondaryStructureFilter]]
* [[SecondaryStructureCountFilter]]
* [[SecondaryStructureHasResidueFilter]]
