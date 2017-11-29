# MembAccesResidueLipophilicityFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*

documentation written by Jonathan Weinstein jonathan.weinstein@weizmann.ac.il, Nov 2017

## MembAccesResidueLipophilicityFilter
similar to [[ResidueLipophilicityFilter]], this filter is tightly based on [[MPResdiueLipophilicityEnergy]].
this filter checks the membrane insertion energy of every residue in the membrane, multiplied by it's relative SASA. this is basically the residue lipophilicity part of the total membrane insertion of the folded protein.

## See also
* [[ResidueLipophilicityFilter]]
* [[TMsAACompFilter]]
* [[HelixHelixAngleFilter]]
* [[SpanTopologyMatchPoseFilter]]
* [[MPSpanAngleFilter]]