GlycanInfo
==========


MetaData
========
App created by Dr. Jared-Adolf-Bryfogle (jadolfbr@gmail.com); Lab of Dr. William Schief (schief@scripps.edu), in collaboration with Dr. Sebastian Raemisch (raemisch@scripps.edu) and Dr. Jason W. Labonte (JWLabonte@JHU.edu); Lab of Dr. Jeff Gray (jgray@jhu.edu) 

Description
===========
The app prints out information for each glycan tree, including rosetta numbering, pdb numbering, internal-glycan numbering, and the connections of every residue in the tree.  It is very useful when dealing with more than one glycan tree, or when one needs to work with particular components of the glycan.

Use
===

Example command-line:
```
glycan_clash_check.default.macosclangrelease -include_sugars \
-s pose_with_glycan.pdb 
```

NOTE: It will not echo any PDB files, and will print the information to the screen.

Options
=======

 - group: ```carbohydrates:GlycanInfo```

    ```
    Opt: -res_info 
        Type: StringVector 
        Desc: Only output info for a specific residue or 
              residues (or full glycan roots).  
              Either rosetta resnum or PDBNumChain 
              as in Rosetta Scripts (133A).
        Ex: -res_info 133A 140B 150C
    ```



## See Also
* [[WorkingWithGlycans]]

### RosettaScript Components
* [[GlycanTreeModeler]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
* [[SimpleGlycosylateMover]] - Glycosylate poses with glycan trees.  
* [[GlycanResidueSelector]] - Select specific residues of each glycan tree of interest.

### Other
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files