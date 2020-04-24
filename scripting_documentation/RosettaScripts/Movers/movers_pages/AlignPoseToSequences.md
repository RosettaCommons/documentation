# [[ AlignPoseToSequences ]]
*Back to [[Mover|Movers-RosettaScripts]] page.*
## [[ AlignPoseToSequences ]]

[[include:mover_AlignPoseToSequences_type]]

Purpose:
The goal of this application is to provide the ability to align the pose's sequence to a reference sequence.
This is particularly useful when performing structure prediction, ie:
If you are predicting the structure of residues 341-400 with Rosetta the output pdb will often start with residue 1 and end at residue 60.  Adding this mover will make sure that the pdb's numbering will be correct (ie numbered as residue 341->400) at the end.

Example application:
```
<ROSETTASCRIPTS>
	<MOVERS>
		<AlignPoseToSequenceMover name="apts" mode="multiple" >
			<Target sequence="MKVKIKCWNGVATWLWVANDENCGICRMAFNGCCPDCKVPGDDCPLVWGQCSHCFHMHCILKWLHAQQVQQHCPMCRQEWKFKE" chains="C,D" />\n"
			<Target sequence="LSDYNIQKESTLHLVLRLRGGMQIFVKTLTGKTITLEVEPSDTIENVKA" chains="U,u" />\n"
		</AlignPoseToSequenceMover>
	</MOVERS>
	<PROTOCOLS>
		<Add mover="apts" />
	</PROTOCOLS>
	<OUTPUT />
</ROSETTASCRIPTS>

```

Option Descriptions here

Caveats--common errors, when not to use this mover

##See Also

