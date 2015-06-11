#extract\_atomtree\_diffs application

Metadata
========

Author: Lucas Nivon

This document was written 21 Sept 2010 by Lucas Nivon, based largely on the ligand\_dock documentation by Ian W. Davis.

Code and Demo
=============

See `       rosetta/tests/integration/tests/extract_atomtree_diffs      ` for an example atomtree\_diff format "silent file" and example usage. Note that this differs from the non-atomtree-diff format silent file because it stores one reference structure at the beginning followed by a diff for each structure from the reference structure.

References
==========

-   Ian W. Davis and David Baker (2009). "ROSETTALIGAND docking with full ligand and receptor flexibility" J Mol Biol. Vol. 385, issue 2. Pages 381-392.

Application purpose
===========================================

This app extracts a pdb with associated rosetta scoring from an atomtree\_diff formatted silent file.

Algorithm
=========

The atomtree\_diff format silent file stores many pdbs in a compact form. It stores the full pdb record of a first, reference, structure and for all subsequent structures only stores the difference (diff) between the atomtree of the structure and the reference structure. This application can extract all of the structures in a silent file to separate pdbs (the default behavior) or only the desired structures (as specified with the "tags" option).

Limitations
===========

This app is only for extraction of pdbs from atomtree\_diff format silent files, not from "standard" silent files. atomtree\_diff format silent files are generated, for example, by the ligand\_dock application.

Modes
=====

The default mode extracts all structures in a silent file. Use of the "tags" options will limit the extraction only to the specified structures.

Input Files
===========

This app requires an atomtree\_diff silent file (\*\_silent.out). If there is a ligand it requires the specification file for the ligand (\*.params) along with an associated conformations of the ligand (\*\_confs.fa.pdb.gz or just \*.pdb).

-   atomtree\_diff silent file (e.g. `        rosetta/main/tests/integration/tests/extract_atomtree_diffs/inputs/7cpa_no_ligand_CP1_silent.out       `)
-   ligand .params files and associated ligand pdb conformers (see [[ligand_dock|ligand-dock]] for details and examples at: `        rosetta/main/tests/integration/tests/extract_atomtree_diffs/inputs/CP1.fa.params and CP1_confs.fa.pdb.gz       `)

An example command line to extract just one structure (using the files in `       rosetta/main/tests/integration/tests/extract_atomtree_diffs      `):

```
~/rosetta/main/source/bin/extract_atomtree_diffs.linuxgccrelease -database /path/to/rosetta/main/database -extra_res_fa inputs/CP1.fa.params -s inputs/7cpa_no_ligand_CP1_silent.out -tags 7cpa_no_ligand_CP1_0_0012
```

A rosetta run will produce an atomtree diff format silent file that contains the endpoint of every trajectory. These silent files can be safely concatenated to give a single output file per ligand. Make sure to use `       -out:prefix      ` and/or `       -out:suffix      ` with each process to ensure unique tag names, however.

This app uses (Ian Davis's) "atomtree diff" format which is very efficient: one reference structure plus \~10 kb per additional structure. This is important for any protocol, such as ligand docking, that can produces output structures rapidly (e.g. one per minute or faster) and dumping full PDBs would overwhelm the shared file system. After the initial reference structure in PDB format, atomtree diff silent file entries look like this:

```
POSE_TAG 7cpa_0_0_0001
SCORES 7cpa_0_0_0001 angle_constraint 0 atom_pair_constraint 0 chainbreak 0 coordinate_constraint 7.16583 dihedral_constraint 0.742443 ... total_score -1006.22
MUTATE 66 LEU_p:protein_cutpoint_lower
MUTATE 67 GLY_p:protein_cutpoint_upper
...
FOLD_TREE  EDGE 1 307 -1  EDGE 1 308 1  EDGE 1 309 2
66 5 0.032845
66 8 -0.916
66 9 1.628
...
309 72 3.141216 1.048102
309 73 -3.139298 1.047107
309 74 -3.140680 1.055816
JUMP 1 0.921608570732 -0.387947033110 -0.011607835912 -0.173665196042 -0.385443938354 -0.906241342066 0.347099469947 0.837215665099 -0.422601334682 5.8930 5.1449 -27.6719
JUMP 2 0.042857484863 0.122530593587 0.991538950131 -0.877881019816 0.478410411182 -0.021175304449 -0.476957179459 -0.869545704439 0.128070749413 3.8597 8.9944 -31.2992
END_POSE_TAG 7cpa_0_0_0001
```

The format for each atomtree diff line is as follows ( `       rosetta/main/source/src/core/io/atom_tree_diffs/atom_tree_diff.cc      `):
 Format: resno atomno phi [theta [d]], only for atoms with changed DOFs
 Phi comes first because dihedrals change most often.
 Theta comes next because in most cases bond angles don't change, so we can omit it!
 D comes last and requires least precision, because it doesn't control a lever-arm effect.

The label "7cpa\_0\_0\_0001" is a "tag", used for uniquely identifying each docking result – like a file name in a directory. By default, all structures in the silent file are extracted, but you can extract only the best scoring ones (for example) by listing the tags on the command line with the `       -tags      ` flag.

The supplied script `       best_ifaceE.py      ` will read a silent file and print the tags of the best-scoring poses. In the Bash shell, you can use this output directly to get the 10 best poses:

```
~/rosetta/main/source/bin/extract_atomtree_diffs.macosgccrelease -database /path/to/rosetta/main/database -extra_res_fa input/1t3r.params \
  -s 1t3r_silent.out -tags $(~/rosetta/main/source/src/apps/public/ligand_docking/best_ifaceE.py -n 10 1t3r_silent.out)
```

Atomtree diff files are plain text, and final scores are recorded on the SCORES lines. These can be easily processed by scripts to select the best results. It can be useful to convert to a table of scores (CSV or equivalent) and do analysis in R; one could do the same in Excel, etc.

```
~/rosetta/main/source/src/apps/public/ligand_docking/get_scores.py < 1t3r_silent.out > 1t3r_scores.tab
```

The following applies to output from ligand docking:

Scores of interest include "total\_score", the overall Rosetta energy for the receptor-ligand complex; "interface\_delta", which estimates the binding energy as the difference between total\_score and the score of the separated components; and "ligand\_auto\_rms\_no\_super", the RMSD between the final ligand position and its position in the input (or `       -native      `) PDB file, accounting for any chemical symmetries (automorphisms). The individual components of total\_score are also present, as are the components of interface\_delta (prefixed by "if\_").

Ian Davis reports good results with the following ranking scheme. First discard any structures where the ligand is not touching the protein (ligand\_is\_touching = 0). Then take the top 5% by total energy (total\_score). Then rank the rest by the interaction energy between protein and ligand only (interface\_delta); this is the score difference between the components together and the components pulled apart by 500A. Among the lowest energy structures, this eliminates some uncorrelated noise from minor variation in the protein and focuses on protein-ligand interactions. This is the scoring scheme implemented by `       best_ifaceE.py      ` , which can be run directly on the silent file to discover the "best" docking results.

If the initial position of the ligand is meaningful (e.g. benchmarking to reproduce a known binding mode), then plot interface\_delta for these top-scoring structures against ligand\_auto\_rms\_no\_super and you should get a nice docking funnel. The ligand\_auto\_rms\_with\_super can be used to see how much ligand conformational variation you're getting in the output structures. (The difference is whether or not the ligands are superimposed; the "auto" is short for "automorphism", which means certain kinds of chemical symmetry are accounted for when calculating the RMS.)

Options
=======

Specify the input silent file. If there is a ligand specify the relevant params file. The default behavior will output pdbs for all structures in the silent file, but to extract only desired files specify them with the -tags option

-   -s [silent file]
-   -extra\_res\_fa [ligand params file]
-   -tags [the name of the desired tag]
-   Note that the tags can be read by hand directly in the silent.out file, as each structure begins with a POSE\_TAG line that specifies the tag name for that structure. The desired tags may come from another script, such as bestifaceE.py (For example: `~/rosetta/main/source/src/apps/public/ligand_docking/best_ifaceE.py -n 10 1t3r_silent.out`).

Tips
====

Use the -tags option to specify which structure to extract.

Expected Outputs
================

This app produces pdb files with rosetta scoring.

## See Also

* [[Utility applications | utilities-applications]]: other utility applications
* [[Old fragment picker | fragment-picking-old]]: the old fragment picker.
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
