# Sequence profile Constraints
*Back to [[Mover|Movers-RosettaScripts]] page.*
## profile

[[include:mover_profile_type]]

Sets constraints on the sequence of the pose that can be based on a sequence alignment or an amino-acid transition matrix.

```xml
<profile weight="(0.25 &Real)" file_name="(<input file name >.cst &string)"/>
```

sets residue_type type constraints to the pose based on a sequence profile. file_name defaults to the input file name with the suffix changed to ".cst". So, a file called xxxx_yyyy.25.jjj.pdb would imply xxxx_yyyy.cst. To generate sequence-profile constraint files with these defaults use DockScripts/seq_prof/seq_prof_wrapper.sh

##See Also
* [[RosettaScriptsPlacement]]: More about the hotspot placement framework.
* [[I want to do x]]: Guide to choosing a mover