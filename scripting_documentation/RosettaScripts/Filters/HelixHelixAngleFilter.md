# HelixHelixAngleFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*

documentation written by Jonathan Weinstein jonathan.weinstein@weizmann.ac.il, Nov 2017

## HelixHelixAngleFilter
finds a vector which is a linear regression of all backbone atoms in each TM span specified by the user.
this filter calculates one of 3 things:
1. the crossing angle between the vecors
2. the distance between the vectors at the nearest point along the vectors
3. the closest distance between the helices (in actual atomic distance)

```
<HelixHelixAngleFilter name="(& string)" start_helix_1="(0 Size)" start_helix_2="(0 Size)" end_helix_1="(0 Size)" end_helix_2="(0 Size)" angle_min="(40.0 Real)" angle_max="(100.0 Real)" dist_min="(0.0 Real)" dist_max="(5.0 Real)" angle_or_dist="(angle string)" dist_by_atom="(true bool)"/>
```

- start_helix_1 - optional - the starting residue of helix 1 in rosetta numbering
- end_helix_1 - optional - the ending residue of helix 1 in rosetta numbering
- start_helix_2 - optional - the starting residue of helix 2 in rosetta numbering
- end_helix_2 - optional - the ending residue of helix 2 in rosetta numbering
- angle_min - the minimal angle to allow
- angle_max - the maximal angle to allow
- dist_min - the minimal distance to allow
- dist_max - the maximal distance to allow
- angle_or_dist - a stirng specifying whether to calculate an ngle or distance (angle/dist, default is angle)
- dist_by_atom - whether to calculate the distance by atom or vector
- helix_num_1 - choose the helix 1 from the DSSP data of the pose (1 will be the first helix in the pose, 2 the second, etc.)
- helix_num_2 - choose helix 2, same as 1


## See also
* [[MPResidueLipophilicityEnergy]]
* [[ResidueLipophilicityFilter]]
* [[TMsAACompFilter]]
* [[MembAccesResidueLipophilicityFilter]]
* [[HelixHelixAngleFilter]]
* [[SpanTopologyMatchPoseFilter]]
* [[MPSpanAngleFilter]]