MetaData
========
App created by Dr. Jared-Adolf-Bryfogle (jadolfbr@gmail.com); Lab of Dr. William Schief (schief@scripps.edu), in collaboration with Dr. Sebastian Raemisch (raemisch@scripps.edu) and Dr. Jason W. Labonte (JWLabonte@JHU.edu); Lab of Dr. Jeff Gray (jgray@jhu.edu) 
The app is currently in development and only accessible to developers.  July 2016

Description
===========
The app prints out information for each glycan tree, including rosetta numbering, pdb numbering, internal-glycan numbering, and the connections of every residue in the tree.  It is very useful when dealing with more than one glycan tree, or when one needs to work with particular components of the glycan.

<!--- BEGIN_INTERNAL -->

Use
===

Example command-line:
```
glycan_clash_check.default.macosclangrelease -s pose_with_glycan.pdb -include_sugars
```

NOTE: It will not echo any PDB files, and will print the information to the screen.

Options
=======

 - group: carbohydrates:GlycanInfo

    ```
    Opt: res_info 
        Type: StringVector 
        Desc: Only output info for a specific residue or residues (or full glycan roots).  Either rosetta resnum or PDBNumChain as in Rosetta Scripts (133A).
        Ex: res_info 133A 140B 150C
    ```







<!--- END_INTERNAL -->