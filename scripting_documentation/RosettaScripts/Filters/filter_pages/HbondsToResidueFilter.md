# HbondsToResidue
This page was last modified on 7 July 2015 by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory.
*Back to [[Filters|Filters-RosettaScripts]] page.*
## HbondsToResidue

This filter counts the number of residues that form hydrogen bonds to a selected residue, where each hydrogen bond needs to have, at most, energy\_cutoff energy. For backbone-backone hydrogen bonds, turn the <b>bb_bb</b> flag on.

This filter was originally written in the context of protein interface design, and was subsequently rewritten completely to be a general hydrogen bond counter.  To count only hydrogen bonds between a residue and residues in other chains, turn on the <b>from_other_chains_only</b> flag.

```
<HbondsToResidue name=(hbonds_filter &string) partners=(&integer) energy_cutoff=(-0.5 &float) backbone=(false &bool) bb_bb=(false &bool) sidechain=(true &bool) residue=(&string) from_other_chains_only=(false &bool)>
```

-   partners: How many H-bonding partners are expected?  The number of partners detected must be equal to or greater than this value in order for the filter to pass. 
-   backbone: Should we count hydrogen bonds involving backbone?
-   sidechain: Should we count hydrogen bonds involving sidechains?
-   bb_bb: Should we count backbone-backbone hydrogen bonds?
-   residue: The residue number whose hydrogen bonding we're examining.  This can be a Rosetta number (e.g. "32"), a PDB number (e.g. "12B"), or a number based on references poses (e.g. "refpose(snapshot1,35)").  See the note on [[this page|RosettaScripts-Conventions]] about the RosettaScripts conventions for residue indices.

## See also

* [[EnergyPerResidueFilter]]
* [[BuriedUnsatHbondsFilter]]
* [[HbondsToAtomFilter]]
* [[ResidueBurialFilter]]
* [[ResidueDistanceFilter]]
* [[ResidueInteractionEnergy|ResidueIEFilter]]
* [[RosettaScripts Conventions for selecting residue indices|RosettaScripts-Conventions]]
