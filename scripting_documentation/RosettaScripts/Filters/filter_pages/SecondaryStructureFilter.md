# SecondaryStructure
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SecondaryStructure

```
      <SecondaryStructure name=(&string, required) use_abego=(&int, optional) blueprint=(&string) ss=(&string) abego=(&string) threshold=(&real, 1.0) />
```

Filter structures based on the SecondaryStructure, either from a string (EEEEEHHHH) or from a blueprint.

**Usage of dssp mover is required** : You must call the dssp mover prior to applying this filter, as in the example below.

-   ss: secondary structure string, e.g. "HHHHHLLLHHHHH" \<LE\> abego: string of abego values, turn on use\_abego
-   use\_abego: 0 or 1. (optional, requires abego values to match those specified in the blueprint)
-   blueprint: filename string format for a blueprint file (e.g. "../input.blueprint"; standard blueprint file)
-   threshold: Fraction of secondary structure that must match the desired secondary structure in order for the pose to pass the filter. (default=1.0).  1.0 indicates that all residues must match the desired secondary structure.

**Secondary Structure specification** :

-   E: sheet
-   H: helix
-   h: not helix (so either E or L)
-   L: loop
-   D: wildcard (allows anything)

Example with a blueprint:

```
      <SecondaryStructure name=ss_filter1  use_abego=1 blueprint="input.blueprint" />
```

Examples with top7 derived structures

(Input)

```
<FILTERS>
        <SecondaryStructure name=ss ss=LEEEEEEEELLLLEEEEEEEELLLLHHHHHHHHHHHHHHHLLLEEEEEEELLLHHHHHHHHHHHHHHHHHLLLLhhEEEEELLEEEEEEEL/>
</FILTERS>
<MOVERS>
         <Dssp name=dssp/>
</MOVERS>
<PROTOCOLS>
    <Add mover=dssp/>
        <Add filter=ss/>
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
