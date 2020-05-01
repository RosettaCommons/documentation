# [[ AlignPDBInfoToSequences ]]
*Back to [[Mover|Movers-RosettaScripts]] page.*
## [[ AlignPDBInfoToSequences ]]

[[include:mover_AlignPDBInfoToSequences_type]]

Purpose:
The goal of this application is to provide the ability to align the pose's sequence (PDBInfo) to reference sequences.
This is particularly useful when performing structure prediction, ie:
If you are predicting the structure of residues 341-400 with Rosetta the output pdb will often start with residue 1 and end at residue 60.  Adding this mover will make sure that the pdb's numbering will be correct (ie numbered as residue 341->400) at the end.

Example application:
```
<ROSETTASCRIPTS>
	<MOVERS>
		<AlignPDBInfoToSequences name="apts" mode="multiple" >
			<Target sequence="MKVKIKCWNGVATWLWVANDENCGICRMAFNGCCPDCKVPGDDCPLVWGQCSHCFHMHCILKWLHAQQVQQHCPMCRQEWKFKE" chains="C,D" />\n"
			<Target sequence="LSDYNIQKESTLHLVLRLRGGMQIFVKTLTGKTITLEVEPSDTIENVKA" chains="U,u" />\n"
		</AlignPDBInfoToSequences>
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
## Option Descriptions

because there's no standard format that can really handle the level of control I want, I've decided to go with the following:

in 'single' mode:
given the json file (or its equivalent `Target` block)
```
[
   {
       "sequence": "SEQ",
       "chains": ["A", "B", "C"],
       "segmentIDs": ["SEQ"]
   },
   {
       "sequence": "HERE",
       "chains": ["D"],
       "segmentIDs": ["HERE"]
   },

]
```
the mover will alter the PDBInfo of the a pose with two chains with sequences ["SEQ", "HERE"] to:

the residue numbering:
```
[1, 2, 3, 1, 2, 3, 4]
```
chains:
```
["A", "B", "C", "D", "D", "D", "D"]
```
segmentIDs:
```
["SEQ", "SEQ", "SEQ", "HERE", "HERE", "HERE", "HERE"]
```

This is useful, but normally you have 20+ chains and their order isn't consistent between experiments so instead using the 'multiple' mode

given a pose with sequences ["SEQ", "HERE", "SEQ"]
you could align this with the json (or equivalent `Target` block):

```
[
   {
       "sequence": "SEQ",
       "chains": ["A", "B"],
       "segmentIDs": ["SEQ1", "SEQ2"]
   },
   {
       "sequence": "HERE",
       "chains": ["D"],
       "segmentIDs": ["HERE"]
   },
]
```
and this will result in the:

residue numbering:
```
[1, 2, 3, 1, 2, 3, 4, 1, 2, 3]
```
chains:
```
["A", "A", "A", "D", "D", "D", "D", "B", "B", "B"]
```
segmentIDs:
```
["SEQ1", "SEQ1", "SEQ1", "HERE", "HERE", "HERE", "HERE", "SEQ2", "SEQ2", "SEQ2"]
```

so using 'single' mode you have more per 'residue' control but less flexibility on the pose ordering, whereas in 'multiple' mode you have less per 'residue' control but lots of flexibility on the pose ordering.


## Caveats--common errors, when not to use this mover

One big problem (or feature) with this mover is that the sequences of the pose chains must identically match the target sequences.  Even if you're off by just 1 residue, the SmithWaterman can fail. and your pose will not be properly aligned.  Be extra careful when blindly using this protocol in combination with downstream protocols!

 
