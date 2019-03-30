# HelixPairing
*Back to [[Filters|Filters-RosettaScripts]] page.*
## HelixPairing

Filter structures based on the geometry of helix pairings.  The filter first determines the secondary structure of the pose, then uses that secondary structure to find helices. Relating helix pairing geometry, this filter provides three parameters, dist, cross, and align, and the structures of which parameters are "below" thresholds are filtered.

###Secondary Structure
Pose secondary structure is determined by the following rules:
1. If secstruct is set, that is used as the pose secondary structure.
2. If use_dssp is true, DSSP is used to compute pose secondary structure, and this is used as the pose secondary structure.
3. If use_dssp is false, the secondary structure stored in the pose is directly used. Note that this secondary structure is not guaranteeed to match the contents of the pose unless it is properly set by a mover. It may be a string of 'L' or it may be spaces, or it may be something altogether different.

###Helix Determination
The secondary structure determined above is then used to find helices in the pose. The filter then searches for the desired helix pairings.  Helix numbers in the pairings are found in the pose and these regions are analyzed.

If no helix pairings are given, this implies that all helix pairings are satisfied, and the filter returns true.  If, however, helix pairings are given with helix numbers that do not exist in the pose, the filter returns false because something is likely to be wrong with the pose secondary structure.


```xml
<HelixPairing name="(&string)"
              secstruct="('' &string)"
              use_dssp="(false &bool)"
              blueprint="('' &string)"
              helix_pairings="('' &string)"
              dist="(15.0 &Real)"
              cross="(45.0 &Real)"
              align="(25.0 &Real)"
              bend="(20.0 &Real)"
              output_id="(1 &Integer)"
              output_type="('dist' &string)" />
```
-   secstruct: If specified, the given secondary structure will be forcibly assigned to the pose and used to determine the locations of helices. The secondary structure must be the same length as the input pose.
-   use_dssp: Only works if secstruct is unspecified. If true, DSSP will be used to determine the pose secondary structure.  If false, the secondary structure information stored in the pose will be used.
-   helix\_pairings: If specified, the given helix pairings will be filtered. Each helix pairing is described by paired helix indices separated by "-" with orientations (P or A) after dot ".". Ex. 1-2.A means the pairing between the 1st and 2nd helices. The multiple pairings are concatenated with semicolon ";". Ex. 1-2.A;2-3.A;1-3.P.  If unspecified, helix pairings will be determined at run time if helix pairings are cached in the pose if present. Note that if no helix pairings are specified, the filter will always return true.
-   dist: distance between mid points of paired helices
-   cross: angle between helix vectors. The helix vector is between the centers of C- and N- terminal helix.
-   align: angle between helix vectors projected onto beta sheet that is defined by the strands immediately followed before the helices. This is calculated only when the strands exists within 6 residues before the helices.
-   bend: check bend of intra helix. This is not pairing related parameter, but for checking the intra helix bending. Basically, you don't need change this parameter.
-   output\_id: the helix pair id to be output in score file. e.g. 1 means 1-2.A in 1-2.A;2-3.P.
-   output\_type: parameter type to be output in score file, dist, cross, or align.
-   blueprint: If specified, a blueprint file will be used to set the desired pose secondary structure. If helix pairing information is present in the blueprint, and "helix_pairings" option is not given, the pairings will also be set. If helix pairing information is present in the blueprint and "helix_pairings" is given, the pairings in the blueprint will be ignored. See [[rosettaremodel]] and [[Remodel]] for blueprint info.

## See also

* [[AbInitio Modeling|abinitio-relax]]
* [[Loop Modeling|loopmodel]]
* [[HelixKinkFilter]]
* [[SecondaryStructureFilter]]
* [[SecondaryStructureCountFilter]]
* [[SecondaryStructureHasResidueFilter]]
