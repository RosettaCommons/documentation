Metadata
========

Authors: Dr. Jared Adolf-Bryfogle (jadolfbr@gmail.com), Dr. Sebastian Raemisch(raemisch@gmail.com), and Dr. Jason W. Labonte (JWLabonte@jhu.edu)

PIs: Jeff Gray and William Schief



Description
===========

Selects All Glycan residues in a pose, or particular glycan trees.  Currently in development.

<!--- BEGIN_INTERNAL -->

Usage
=====

``` 
    <GlycanTreeSelector name=(&string) roots="23,48", ref_pose_name="ref_pose"/>
```


_root_ &string

_roots_ &string,&string&string
- Used to set specific glycan trees or parts of trees.  If this is not given, it will select ALL glycan residues in the pose.  These can be the branch points of the glycans or carbohydrate residues from which to select the downstream branch from, like the rest of a tree from a particular position.  That position could be the trunk or individual branches, which keep branching out. Note that the Subset will not include the Root residue, since many times it will be the ASN root.

_ref_pose_name_ &string
- The name of a Particular Ref Pose set. 


<!--- END_INTERNAL -->

## See Also
* [[WorkingWithGlycans]]

- ### RosettaScript Components
* [[GlycanRelaxMover]] - Glycosylate poses with glycan trees.  
* [[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest.

- ### Apps
* [[GlycanRelax]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
* [[GlycanInfo]] - Get information on all glycan trees within a pose
* [[GlycanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.

- ### Other
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files