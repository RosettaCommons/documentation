# TMsAACompFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*

documentation written by Jonathan Weinstein jonathan.weinstein@weizmann.ac.il, Nov 2017

## TMsAACompFilter
Calculates the difference of the AA composition of every TM with that of natural TMs. natural TM amino-acid composition based on Liu, Y., et al. 2002, ‘Genomic analysis of membrane protein families: abundance and conserved motifs.’.
as leucine is the most hydrophobic residue in the dsTbL insertion profiles (see [[MPResidueLipophilicityEnergy]], a minimization will substitute every possible membrane facing residue to leucine. when wishing to design with more variability use sigmoids and GenericMonteCarlo, to optimize this filter and the total score.

`<TMsAACompFilter name="(& string) threshold="(0.0 Real)/>`

## See also
* [[MPResidueLipophilicityEnergy]]
* [[ResidueLipophilicityFilter]]
* [[MembAccesResidueLipophilicityFilter]]
* [[HelixHelixAngleFilter]]
* [[SpanTopologyMatchPoseFilter]]
* [[MPSpanAngleFilter]]