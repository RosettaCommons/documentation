#LongestContinuousPolarSegment

Documentation by Yang Hsia (yhsia@uw.edu).  Page created 19 Feb 2018.

*Back to [[Filters|Filters-RosettaScripts]] page.*

##LongestContinuousApolarSegment

This filter counts the number of residues in the longest continuous stretch of apolar amino acids in a structure.  Apolar amino acids are defined as residues that are NOT POLAR (ACFGILMPVWY; see [[Resfile definition|resfiles]]). By default, the filter rejects any structure with apolar stretches longer than a threshold value (set to 5 residues unless the user overrides this).

Note: This filter is a sub-class of the LongestContinuousPolarSegmentFilter.

## Options and Usage

```xml
<LongestContinuousApolarSegment name=(string)
     exclude_chain_termini=(bool,"true")
     filter_out_high=(bool,"true") cutoff=(int,"5")
     residue_selector=(string) confidence=(real,"1.0")
/>
```

**name** -- A unique string by which a particular instance of the filter will be referred in a RosettaScripts XML file.

**exclude\_chain\_termini** -- If false, apolar stretches that reach the N- or C-terminus of a chain will be counted.  If true (the default), these terminal stretches will be ignored, and only internal apolar stretches will be considered.

**filter\_out\_high** -- If true, poses with more than the cutoff number of residues in the longest apolar stretch will be rejected.  If false, poses with fewer than the cutoff number of residues in the longest apolar stretch will be rejected.  True by default.

**cutoff** -- The maximum (or minimum, if "filter_out_high" is set to "false") number of residues in the longest apolar stretch that will still allow the pose to pass this filter.  Default 5.

**residue\_selector** -- An optional, previously-defined residue selector.  If provided, the filter will only consider stretches of apolar residues that have at least one residue in the selection.  Not used if not specified.

**confidence** -- Probability that the pose will be filtered out if it does not pass this Filter

## See also

* [[ResidueCount|ResidueCountFilter]] filter.