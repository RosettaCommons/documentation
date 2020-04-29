# [[ AlignPoseToSequences ]]
*Back to [[Mover|Movers-RosettaScripts]] page.*
## [[ AlignPoseToSequences ]]

[[include:mover_AlignPoseToSequences_type]]

Purpose:
The goal of this application is to provide the ability to align the pose's sequence (PDBInfo) to a reference sequence.
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
Each `Target` must have `sequence` and `chains` defined, but can also have `segmentIDs` and/or `insCodes` defined if you would like to define those as well.

If you don't want to use `Target` blocks you can supply 1 or more json files (comma separated) with the "json_fns" option.
the json files must follow the format: (List of Dictionaries, with required keys of `chain`+`sequence` (optional keys of `segmentIDs` and `insCodes`)

```
[
	{
		"chains": ["C"],
		"sequence": "MKVKIKCWNGVATWLWVANDENCGICRMAFNGCCPDCKVPGDDCPLVWGQCSHCFHMHCILKWLHAQQVQQHCPMCRQEWKFKE"
	},
	{
		"chains": ["D"],
		"sequence": "MSTLFPSLFPRVTETLWFNLDRPCVEETELQQQEQQHQAWLQSIAEKDNNLVPIGKPASEHYDDEEEEDDEDDEDSEEDSEDDEDMQDMDEMNDYNESPDDGEVNEVDMEGNEQDQDQWMI"
	},
	{
		"chains": ["G", "W"],
		"sequence": "MLRRKPTRLELKLDDIEEFENIRKDLETRKKQKEDVEVVGGSDGEGAIGLSSDPKSREQMINDRIGYKPQPKPNNRSSQFGSLEF"
	},
]

```
Option Descriptions here

Caveats--common errors, when not to use this mover

One big problem (or feature) with this mover is that the sequences of the pose chains must identically match the target sequences.  Even if you're off by just 1 residue, the SmithWaterman can fail. and your pose will not be properly aligned.  Be extra careful when blindly using this protocol in combination with downstream protocols!

 
##See Also

