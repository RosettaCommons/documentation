# MotifGraft
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MotifGraft

MotifGraft is a new implementation of the well know motif grafting protocol. The protocol can recapitulate previous grafts made by the previous Fortran protocol (de novo loop insertions has not been implemented yet). The current protocol ONLY performs the GRAFT of the fragment(s), hence invariably, at least, it MUST be followed by design and minimization/repacking steps.

The input is composed by three structures:

1.  Motif, which is the fragment (or fragments) that the user want to graft.
2.  Context, which is the protein (or proteins) that interact with the motif.
3.  Pose (or list of poses), that is the scaffold in which the mover will try to insert the Motif.

The target is to find fragments in the Pose that are compatible with the motif(s), and then replace those fragments with the motif(s). To determine if a fragment is compatible, the algorithm uses three user-definable cut-offs:

1.  RMSD of the fragment(s) alignment (option: RMSD\_tolerance),
2.  RMSD of the N-/C- points after the alignment (option: NC\_points\_RMSD\_tolerance)
3.  clash\_score (option: clash\_score\_cutoff).

The algorithm has two methods of alignment that are mutually exclusive:

1.  Using only the N-/C- points of the fragment(s) (option: full\_motif\_bb\_alignment="0")
2.  Full backbone of the fragment(s) (option: full\_motif\_bb\_alignment="1").

When full backbone alignment is used, the size of the fragment to be replaced has to be exactly the same size of the Motif fragment. Since the grafting can lead to multiple different solutions in a single scaffold, the mover will return by default the top-RMSD match (lowest RMSD in the alignment), however the user can specify the option "-nstruct" to command RosettaScripts in returning more structures, but a disadvantage is that the number of resulting structures is unknown before running the protocol, therefore it is recommended to use the option \<allow\_repeat\_same\_graft\_output="0"\> in combination with a large number of -nstruc (e.g. 100), which effect is to force RosettaScripts to stop generating outputs when the last match (if any) is reached.

An example of a minimal XML code for this mover is the next:

```xml
        <MotifGraft name="motif_grafting" context_structure="./contextStructure.pdb" motif_structure="./motif_2NM1B.pdb"  RMSD_tolerance="1.0" NC_points_RMSD_tolerance="1.0" clash_score_cutoff="5" full_motif_bb_alignment="1" revert_graft_to_native_sequence="1" allow_repeat_same_graft_output="0" />
```

However the mover contains many options that can be useful under different scenarios. Particularly, of special interest are: "hotspots", "allow\_repeat\_same\_graft\_output" and "graft\_only\_hotspots\_by\_replacement". A complete list of the available options follows:

-   context\_structure (&string): The path/name of the context structure pdb.
-   motif\_structure (&string): The path/name of the motif pdb (can contain multiple discontiguos motif separated by the keyword TER).
-   RMSD\_tolerance (&real): The maximum RMSD tolerance (Angstrom) for the alignment.
-   NC\_points\_RMSD\_tolerance (&real): The maximum RMSD tolerance (Angstrom) for the N-/C-points, after the alignment.
-   clash\_test\_residue (&string):The Motif will be mutated before test for clashes (possible values: "GLY", "ALA", "VAL", "NATIVE"), except if the option "NATIVE" is specified. It is recommended to use "GLY or "ALA".
-   clash\_score\_cutoff (&int): The maximum number of atomic clashes that are tolerated. The number of atom clashes are = (motif vs scaffold) + ( scaffold vs pose), after the translation and mutation (to the "clash\_test\_residue") of the scaffold. Recommended: "5".
-   combinatory\_fragment\_size\_delta (&string): Is a string separated by a semicolon that defines the maximum number of amino acids in which the Motif size can be variated in the N- and C-terminal regions (e.g. "positive-int:positive-int"). If several fragments are present the values should be specified by the addition of a comma (eg. 0:0, 1:2, 0:3). All the possible combinations in deltas of 1 amino acid will be tested.
-   max\_fragment\_replacement\_size\_delta (&string): Is a string separated by a semicolon that specifies a range with the minimum and maximum size difference of the fragment that can be replaced in the scaffold. For example: "-1:2", means that the fragment replaced in the scaffold can be in the range of motifSize-1 to motifSize+2, practically: if the motif size is 10a.a., in this example the motif can replace a fragment in the scaffold of 9,10 or 11 amino acids. (possible values: negative-int:positive-int). If several fragments are present the values should be specified by the addition of a comma (eg. -1:0, -1:2, 0:3). This option has effect only if the alignment mode is set to full\_motif\_bb\_alignment="0" .
-   hotspots (&string): Is a string separated by a semicolon that defines the index of the aminoacids that are considered hotspots. i.e. that this positions will not be mutated for clash check and will be labeled in the PDBinfo. The format is "index1:index2:...:indexN"). If several fragments are present the values should be specified by the addition of a comma (eg. 1:2:4,1:2,1:4:6).
-   full\_motif\_bb\_alignment (&bool): Boolean that defines the motif fragment(s) alignment mode is full Backbone or not (i.e. only N-C- points).
-   allow\_independent\_alignment\_per\_fragment (&bool): \*\*EXPERIMENTAL\*\* When more that one fragment is present, after the global alignment, this option will allow each fragment to re-align independently to the scaffold. In most cases you want this option to be turned OFF.
-   graft\_only\_hotspots\_by\_sidechain\_replacement (&bool): Analogous to the old multigraft code option "fragment replacement", this option will only align the scaffold, and then copy the side-chains identities and torsions (only for hotspots). No BB will be modified. This option is useful only if the RMSD between the motif and the target fragment in the scaffold is very low (e.g. \< 0.3 A), otherwise you can expect extraneous results.
-   only\_allow\_if\_NC\_points\_match\_aa\_identity (&bool): This option will only perform grafts if the N-/C- point amino acids in the motif match the amino acids to be replaced in the target Scaffold fragment. This can be useful if for example one is looking to replace a fragment that starts in a S-S bridge.
-   revert\_graft\_to\_native\_sequence (&bool): This option will revert/transform/modify the sequence of the graft piece(s) in the sequence of the native scaffold, except the hotspots. This option only can work in conjunction with the full\_bb alignment mode (full\_motif\_bb\_alignment="1") and, of course, it only makes sense if you are replacing fragments in the target scaffold that are of the same size of your motif, which is the default behavior for full\_bb alignment.
-   allow\_repeat\_same\_graft\_output (&bool): If turned on (option: allow\_repeat\_same\_graft\_output="1") it will prevent the generation of repeated outputs, in combination with a large number of -nstruc (e.g. 100), it can be useful to extract all the matches without repetition, since when the last n-graft match is reached the mover will stop. if turned off (option: allow\_repeat\_same\_graft\_output="0"), the usual -nstruct behavior will happen, that is: rosetta will stop only when -nstructs are generated (even if it has to repeat n-times the same result) or if the mover fails (i.e. no graft matches at all).

Finally, an example XML Rosettascripts code using all the options for a single fragment graft:

```xml
<MotifGraft name="motif_grafting" context_structure="./context.pdb" motif_structure="./motif.pdb" RMSD_tolerance="1.0"   NC_points_RMSD_tolerance="1.0" clash_test_residue="GLY" clash_score_cutoff="5" combinatory_fragment_size_delta="0:0" max_fragment_replacement_size_delta="0:0"  hotspots="1:2:4" full_motif_bb_alignment="1"  optimum_alignment_per_fragment="0" graft_only_hotspots_by_replacement="0" only_allow_if_NC_points_match_aa_identity="0" revert_graft_to_native_sequence="0" allow_repeat_same_graft_output="0"/>
```

and for a two fragments graft:

```xml
<MotifGraft name="motif_grafting" context_structure="./context.pdb" motif_structure="./motif.pdb" RMSD_tolerance="1.0"   NC_points_RMSD_tolerance="1.0" clash_test_residue="GLY" clash_score_cutoff="0.0" combinatory_fragment_size_delta="0:0,0:0" max_fragment_replacement_size_delta="0:0,0:0"  hotspots="1:2:4,1:3" full_motif_bb_alignment="1"  optimum_alignment_per_fragment="0" graft_only_hotspots_by_replacement="0" only_allow_if_NC_points_match_aa_identity="0" revert_graft_to_native_sequence="0" allow_repeat_same_graft_output="0"/>
```

 Task operations after MotifGraft : For your convinience, the mover will generate some PDBinfo labels inside the pose. The available labels are: "HOTSPOT", "CONTEXT", "SCAFFOLD", "MOTIF" and "CONNECTION", which luckily correspond exactly to the elements that each of the labels describe. You can easily use this information in residue level task operations in order to prevent or restrict modifications for particular elements. Example:

```xml
        <OperateOnCertainResidues name="hotspot_onlyrepack">
            <ResiduePDBInfoHasLabel property="HOTSPOT"/>
            <RestrictToRepackingRLT/>
        </OperateOnCertainResidues>
        <OperateOnCertainResidues name="scaffold_onlyrepack">
            <ResiduePDBInfoHasLabel property="SCAFFOLD"/>
            <RestrictToRepackingRLT/>
        </OperateOnCertainResidues>
        <OperateOnCertainResidues name="context_norepack">
            <ResiduePDBInfoHasLabel property="CONTEXT"/>
            <PreventRepackingRLT/>
        </OperateOnCertainResidues>
```


##See Also

* [[FastDesignMover]]
* [[FastRelaxMover]]
* [[Abinitio relax]]: Application for *de novo* structure prediction
* [[MinMover]]
* [[Minimization overview]]
* [[I want to do x]]: Guide to chosing a mover
