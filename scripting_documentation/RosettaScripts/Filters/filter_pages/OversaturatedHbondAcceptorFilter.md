# OversaturatedHbondAcceptorFilter
This page was last modified on 22 May 2016 by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory.
*Back to [[Filters|Filters-RosettaScripts]] page.*
## OversaturatedHbondAcceptorFilter

This filter counts the number of hydrogen bond acceptors that are receiving hydrogen bonds from more than the allowed number of donors.  If the count is greater than a threshold value (default 0), the filter fails.  This filter is intended to address a limitation of Rosetta's pairwise-decomposible hydrogen bond score terms: it is not possible for a score term that is examining the interaction between only two residues to know that a third is also interacting with one of the residues, creating artifacts in which too many hydrogen bond donors are all forming hydrogen bonds to the same acceptor.

```xml
<OversaturatedHbondAcceptorFilter name="(&string)" scorefxn="(&string)" max_allowed_oversaturated="(0 &int)" hbond_energy_cutoff="(-0.1 &Real)" consider_mainchain_only="(true &bool)" donor_selector="(&string)" acceptor_selector="(&string)" >
```
-  scorefxn: What scoring function should be used to score hydrogen bonds?  Default is the global default scorefunction set with the "-score:weights" flag.
-  max_allowed_oversaturated: How many oversaturated acceptors are allowed before the filter fails?  Default 0 (filter fails if any oversaturated acceptors are found).
-  hbond_energy_cutoff: A hydrogen bond must have energy less than or equal to this threshold in order to be counted.  Default -0.1 Rosetta energy units.
-  consider_mainchain_only: If true (the default), only mainchain-mainchain hydrogen bonds are considered.  If false, all hydrogen bonds are considered.
-  donor_selector: An optional, previously-defined ResidueSelector that selects the subset of residues that can donate hydrogen bonds.  If not provided, the whole structure is scanned for donors.
-  acceptor_selector: An optional, previously-defined ResidueSelector that selects the subset of residues that can accept hydrogen bonds.  If not provided, the whole structure is scanned for acceptors.