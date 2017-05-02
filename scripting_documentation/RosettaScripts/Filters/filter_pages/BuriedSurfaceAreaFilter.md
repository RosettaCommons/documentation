# BuriedSurfaceArea
Page created 2 May 2017 by Vikram K. Mulligan, Ph.D. (vmullig@uw.edu).<br/>
*Back to [[Filters|Filters-RosettaScripts]] page.*

## BuriedSurfaceArea

This filter computes the total buried surface area for a pose or a subset of a pose selected by a residue selector.  It discards poses with buried surface area below (or above) a user-defined threshold value.  Note that this filter operates ONLY on canonical L-amino acids, their D-amino acid counterparts, and glycine; it will compute a buried surface area of zero for all other types.

## Usage and options

```xml
<BuriedSurfaceArea name=(string)
     select_only_FAMILYVW=(bool,"false") filter_out_low=(bool,"true")
     cutoff_buried_surface_area=(real,"500") probe_radius=(real,"2.0")
     residue_selector=(string) confidence=(real,"1.0")
/>
```


**name (string):**  The name given to this instance.

**select_only_FAMILYVW (bool,"false"):**  If true, then only hydrophobic residues and alanine (phe, ala, met, ile, leu, tyr, val, or trp) are counted.  If false (the default), then all residues are counted.  Note that, if this is used, this is combined with AND logic to create the final residue selection if a residue selector is also provided (that is, residues that are selected by the selector AND which are in the set FAMILYVW are used to compute the buried surface area).

**filter_out_low (bool,"true"):**  If true (the default), then poses with buried surface area below the cutoff are rejected.  If false, then poses with buried surface area above the cutoff are rejected.

**cutoff_buried_surface_area (real,"500"):**  The buried surface area below which (or above which, if "filter_out_low" is false) a pose is rejected.  Defaults to 500 square Angstroms, an arbitrarily-chosen value.

**probe_radius (real,"2.0"):**  The radius for the probe used in the rolling-ball algorithm for determining solvent-accessible surface area.  The buried surface area is the total minus the solvent accessible.  Defaults to 2.0 Angstroms.

**residue_selector (string):**  An optional, previously-defined residue selector.  If provided, then only the selected residues are used in computing buried surface area.  If not provided, then all residues are used.

**confidence (real,"1.0"):**  Probability that the pose will be filtered out if it does not pass this filter.

## See also

* [[ExposedHydrophobics|ExposedHydrophobicsFilter]] filter
* [[ResidueBurial|ResidueBurialFilter]] filter
* [[Sasa|SasaFilter]] filter
* [[TotalSasa|TotalSasaFilter]] filter