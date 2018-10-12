# SpanTopologyMatchPoseFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*

documentation written by Jonathan Weinstein jonathan.weinstein@weizmann.ac.il, Nov 2017

## SpanTopologyMatchPoseFilter
compares the topology of the actual pose to that required by the span provided to AddMembrane
this is done by creating a topology string, made i/o/H for every position:
1. i - inside the cell
2. o - outside the cell
3. H - transmembrane 
a topology string is created for the actual pose at runtime, and the span required by the user. the identity percentage between these two strings is reported

```
<SpanTopologyMatchPoseFilter name="(& string)"/>
```

## See also
* [[MPResidueLipophilicityEnergy]]
* [[ResidueLipophilicityFilter]]
* [[TMsAACompFilter]]
* [[MembAccesResidueLipophilicityFilter]]
* [[HelixHelixAngleFilter]]
* [[SpanTopologyMatchPoseFilter]]
* [[MPSpanAngleFilter]]