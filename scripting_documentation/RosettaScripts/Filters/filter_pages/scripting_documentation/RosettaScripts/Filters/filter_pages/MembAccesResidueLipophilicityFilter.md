# MembAccesResidueLipophilicityFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*

documentation written by Jonathan Weinstein jonathan.weinstein@weizmann.ac.il, Nov 2017

## MembAccesResidueLipophilicityFilter
similar to [[ResidueLipophilicityFilter]], this filter is tightly based on [[MPResidueLipophilicityEnergy]].
this filter checks the membrane insertion energy of every residue in the membrane, multiplied by it's relative SASA. this is basically the residue lipophilicity part of the total membrane insertion of the folded protein.

```xml
<MembAccesResidueLipophilicityFilter name="(& string) threshold="(0.0 Real) verbose="(false bool)" ignore_burial="(false bool)/>
```

- verbose - whether to print the burial and lipophilicity of every residue
- ignore_burial - whether to multiply lipophilicity by the relative SASA of each residue or not

## See also
* [[MPResidueLipophilicityEnergy]]
* [[ResidueLipophilicityFilter]]
* [[TMsAACompFilter]]
* [[HelixHelixAngleFilter]]
* [[SpanTopologyMatchPoseFilter]]
* [[MPSpanAngleFilter]]