# MPSpanAngleFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*

documentation written by Jonathan Weinstein jonathan.weinstein@weizmann.ac.il, Nov 2017

## MPSpanAngleFilter
two modes of operation
1. return the angle between a TM span and the membrane normal
2. return the difference between the TM span angle and the membrane normal to the distribution of such angles in natural proteins. this is essentially the score found by [[MPSpanAngleEnergy]] for that TM

```
<MPSpanAngleFilter name="(& string)" output_file="(TR string)" tm="(0, Size)" angle_or_score="(angle string)" ang_max="(90 Real)" ang_min="(0 Real)/>
```

- ouptput_file - the output stream for the filter. if TR (defualt) will print to tracer. else will create a file at the specified name
- tm - which TM span to calculate the angle or score for, as found in the pose's DSSP
- ang_max - the maximal angle to allow
- ang_min - the minimal angle to allow

## See also
* [[MPResidueLipophilicityEnergy]]
* [[ResidueLipophilicityFilter]]
* [[TMsAACompFilter]]
* [[MembAccesResidueLipophilicityFilter]]
* [[HelixHelixAngleFilter]]
* [[SpanTopologyMatchPoseFilter]]
* [[MPSpanAngleFilter]]