# SecondaryStructure
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SecondaryStructure

```xml
<SecondaryStructure name="(&string, required)"
    residue_selector="(&string, TrueSelector)"
    use_abego="(&int, optional)"
    blueprint="(&string)"
    ss="(&string)"
    abego="(&string)"
    compute_pose_secstruct_by_dssp="(&bool, false)"
    threshold="(&real, 1.0)" />
```

Filter structures by comparing the secondary structure of the pose to a desired secondary structure. The filter reports a value of N_MATCHING / N_TOTAL, where N_MATCHING is the number of selected protein residues with secondary structure matching the desired secondary structure, and N_TOTAL is the total number of selected protein residues.

If compute_pose_secstruct_by_dssp is false (default), the current secondary structure of the pose must be properly set in the pose. This can be done using [[DsspMover]] as shown in the example below.  If compute_pose_secstruct_by_dssp is false, DSSP will be automatically used on the input pose to determine the pose secondary structure.

-   residue_selector: Residue selector which determines which residues in the pose should be checked.  Note that non-protein residues are always currently skipped. Default: all protein residues.
-   ss: If specified, the provided secondary structure string, e.g. "HHHHHLLLHHHHH" will be used as the desired secondary structure. Must match the length of the input pose. Default: not specified.
-   use_dssp: If false, the secondary structure stored in the pose will be used as the pose secondary structure. This requires that it be set by DsspMover or other means prior to calling the filter.  If true, DSSP is used on the input pose to determine its secondary structure.
-   blueprint: Optional filename string for a blueprint file (e.g. "../input.blueprint"). The desired secondary structure (and abego, if use\_abego=1) will be set using this blueprint file.  This option overrides the desired secondary structure set with the "ss" option.
-   abego: String of desired abego values (e.g. "XAAAAGBABBBB"). The abego string must match the length of the pose. If specified, use\_abego is automatically set to true.
-   use\_abego: 0 or 1. If true, requires abego values to match the desired abego string in addition to secondary structure matches.
-   threshold: Fraction of secondary structure that must match the desired secondary structure in order for the pose to pass the filter. (default=1.0).  1.0 indicates that all residues must match the desired secondary structure.

**Secondary Structure specification** :

-   E: sheet
-   H: helix
-   h: not helix (so either E or L)
-   L: loop
-   D: wildcard (allows anything)

Example with a blueprint:

```xml
      <SecondaryStructure name="ss_filter1"  use_abego="1" blueprint="input.blueprint" />
```

Examples with top7 derived structures

(Input)

```xml
<FILTERS>
        <SecondaryStructure name="ss" ss="LEEEEEEEELLLLEEEEEEEELLLLHHHHHHHHHHHHHHHLLLEEEEEEELLLHHHHHHHHHHHHHHHHHLLLLhhEEEEELLEEEEEEEL"/>
</FILTERS>
<MOVERS>
         <Dssp name="dssp"/>
</MOVERS>
<PROTOCOLS>
    <Add mover="dssp"/>
    <Add filter="ss"/>
</PROTOCOLS>
```

(Output)

```
(when passed) 

protocols.fldsgn.filters.SecondaryStructureFilter: LEEEEEEEELLLLEEEEEEEELLLLHHHHHHHHHHHHHHHLLLEEEEEEELLLHHHHHHHHHHHHHHHHHLLLLhhEEEEELLEEEEEEEL was filtered with 91 residues matching LEEEEEEEELLLLEEEEEEEELLLLHHHHHHHHHHHHHHHLLLEEEEEEELLLHHHHHHHHHHHHHHHHHLLLLLLEEEEELLEEEEEEEL


(when failed)

protocols.fldsgn.filters.SecondaryStructureFilter: SS filter fail: current/filtered = H/L at position 25
protocols.fldsgn.filters.SecondaryStructureFilter: LEEEEEEEELLLLEEEEEEEELLLLHHHHHHHHHHHHHHHLLLEEEEEEELLLHHHHHHHHHHHHHHHHHLLLLhhEEEEELLEEEEEEEL was filtered with 90 residues matching LEEEEEEEELLLLEEEEEEEELLLHHHHHHHHHHHHHHHHLLLEEEEEEELLLHHHHHHHHHHHHHHHHHLLLLEEEEEEELLEEEEEEEL
```

## See also:

* [[AbInitio Modeling|abinitio-relax]]
* [[Loop Modeling|loopmodel]]
* [[AngleToVectorFilter]]
* [[DsspMover]]
* [[GeometryFilter]]
* [[HelixKinkFilter]]
* [[SecondaryStructureHasResidueFilter]]
* [[TorsionFilter]]
