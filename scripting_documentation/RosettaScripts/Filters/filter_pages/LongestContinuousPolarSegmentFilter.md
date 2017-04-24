#LongestContinuousPolarSegment

Documentation by Vikram K. Mulligan, Ph.D. (vmullig@uw.edu).  Page created 23 April 2017.

*Back to [[Filters|Filters-RosettaScripts]] page.*

##LongestContinuousPolarSegment

This filter counts the number of residues in the longest continuous stretch of polar amino acids in a structure.  Polar amino acids include Arg, Asn, Asp, Gln, Glu, His, Lys, Ser, and Thr (residues with the POLAR property in their params files).  Gly may also, optionally, be considered polar, despite lacking the POLAR property in its params file.  By default, the filter rejects any structure with polar stretches longer than a threshold value (set to 5 residues unless the user overrides this).

## Options and Usage

```xml
<LongestContinuousPolarSegment name=(string)
     exclude_chain_termini=(bool,"true")
     count_gly_as_polar=(bool,"true")
     filter_out_high=(bool,"true") cutoff=(int,"5")
     residue_selector=(string) confidence=(real,"1.0")
/>
```

**name** -- A unique string by which a particular instance of the filter will be referred in a RosettaScripts XML file.

**exclude\_chain\_termini** -- If false, polar stretches that reach the N- or C-terminus of a chain will be counted.  If true (the default), these terminal stretches will be ignored, and only internal polar stretches will be considered.

**count\_gly\_as\_polar** -- If true, glycine is considered "polar" for purposes of this filter.  True by default.

**filter\_out\_high** -- If true, poses with more than the cutoff number of residues in the longest polar stretch will be rejected.  If false, poses with fewer than the cutoff number of residues in the longest polar stretch will be rejected.  True by default.

**cutoff** -- The maximum (or minimum, if "filter_out_high" is set to "false") number of residues in the longest polar stretch that will still allow the pose to pass this filter.  Default 5.

**residue\_selector** -- An optional, previously-defined residue selector.  If provided, the filter will only consider stretches of polar residues that have at least one residue in the selection.  Not used if not specified.

**confidence** -- Probability that the pose will be filtered out if it does not pass this Filter

## See also

* [[ResidueCount|ResidueCountFilter]] filter.