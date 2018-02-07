# DatabaseThread
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## DatabaseThread

This task operation is designed to deal with situations in which a pose is changed in a way that adds or removes residues. This creates a problem for normal threading that requires a constant start and stop positions. This task operation can use a database of sequences or a single target sequence. It also need a template pdb to find on the pose a user defined start and end residues. A sequence length and threading start position are calculated and then a correct length sequence is randomly chosen from the database and threaded onto the pose.

```xml
<DatabaseThread name="(&string)" database="('' &string)" target_sequence="('' &string)" template_file="(&string)" start_res="(&int)" end_res="(&int)" allow_design_around="(1 &bool)" design_residues="(comma-delimited list)" keep_original_identity="(comma-delimited list)"/>
```

To actually change the sequence of the pose, you have to call something like PackRotamersMover on the pose using this task operation. Notice that this only packs the threaded sequence, holding everything else constant.

This task operation builds off of ThreadSequence so the same logic applies: 'X' means mark position for design, while ' ' or '\_' means mark pose residue to repacking only.

-   database: The database should be a text file with a list of single letter amino acids (not fasta).
-   target_sequence: The desired sequence if there is only one desired sequence (this can happen if the pose is changed during design such that the start and end positions are not constant. In such cases ThreadSequence is not useful). The task operation expects either a database or a target sequence and will fail if neither are provided. If both are provided the database will be ignored. 
-   template\_file: a pdb that serves as a constant template to map the start and end residues onto the pose in case that the length of the pose is altered during design.
-   start\_res: the residue to start threading from. This is a residue in the template pdb. It is used to find the closest residue on the source pdb.
-   end\_res: the residue to end the threading. This is a residue in the template pdb. It is used to find the closest residue on the source pdb. The delta between the end and start residue is used to find the desired sequence length in the database.
-   allow\_design\_around: if set to false, only design the region that is threaded. The rest is set to repack.
-   design\_residues: the same as placing 'X' in the target sequence. This trumps the sequence in the database so if a residue has a different identity in the database it is changed to 'X'.
-   keep\_original\_identity: the same as placing a ' ' or a '\_' in the sequence. The pose residue is marked for repacking only. This trumps both the database sequence and the list from design\_residues.

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
