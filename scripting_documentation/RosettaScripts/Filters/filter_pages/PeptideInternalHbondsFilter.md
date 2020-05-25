# PeptideInternalHbondsFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*
Page created 23 April 2020 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

## PeptideInternalHbondsFilter

The PeptideInternalHbondsFilter counts hydrogen bonds between residues that are within a residue selection, or, if no residue selection is provided, wihin a pose, and discards pose with counts below a user-defined threshold.  This filter omits from the count any hydrogen bonds that are between residues that are within a user-specified distance in terms of covalent connectivity.  This is particularly useful for finding long-range backbone hydrogen bonds in peptide macrocycles, for example.

The PeptideInternalHbondsFilter is a thin wrapper for the [[PeptideInternalHbondsMetric]], filtering based on the metric's output.

[[include:filter_PeptideInternalHbondsFilter_type]]

## See also

* [[PeptideInternalHbondsMetric]]: Count hydrogen bonds within a selection.  This filter wraps this metric.
* [[OversaturatedHbondAcceptorFilter]]: Discard poses with too many hydrogen bond donors donating to a single hydrogen bond acceptor.
* [[HbondsToResidueFilter]]:  Filter based on the number of hydrogen bonds to a given residue.
