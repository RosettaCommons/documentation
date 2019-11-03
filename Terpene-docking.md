#Terdockin Application

Metadata
========

This document is written on Oct 30 2019 by Yue Zhang (yuezh@ucdavis.edu).

Terdockin (aka terpene docking, Terry docking) is originally developed by Terry O'Brien in Justin B. Siegel lab for terpene synthases docking. You can also get inspiration from this protocol if you are trying to do multi-ligand docking.

Code
========

XML Script can be found here: https://github.com/RosettaCommons/rosetta_scripts_scripts/blob/master/scripts/public/docking/terpeneSynthase_docking.xml.

Input Files
========
In order to run this docking protocol, you'll need the following files:

1. PDB file of the protein. With proper headers for constraints. 

2. params file for all ligands. 

3. Constraint file 

4. Flags file

5. XML file

Examples of these files can be found in ligand docking protocol. XML file can be found in link mentioned above. Caluculation Setup section includes setup details about each file.

Calculation Setup
========
Here is an example file setup for a typical terpene synthase docking protocol. 

### PDB file of the protein

It's recommanded to relax the protein with Rosetta first. Add all ligands to the end of the PDB file. Label Protein as chain A and all ligands as chain B, C, D...
Make sure the header of the PDB file agrees with the constraint file. Example file format:
```
REMARK 666 MATCH TEMPLATE C Y00  1 MATCH MOTIF B X00 1   1  1
REMARK 666 MATCH TEMPLATE B X00  1 MATCH MOTIF A ASP 73  2  1
... 
ATOM      1  N   GLN A   1      56.899  -4.088   0.980  1.00  0.00           N
ATOM      2  CA  GLN A   1      56.216  -4.838  -0.121  1.00  0.00           C   
...
TER
HETATM    1  P1  X00 B   1      30.437 -11.786   3.932  1.00 20.00           P  
HETATM    2  P2  X00 B   1      29.144 -11.943   6.478  1.00 20.00           P  
...
TER
```
### Params file for all ligands

This can be generated from mol2 file. 

See instruction here: [Preparing Ligands](https://www.rosettacommons.org/demos/latest/tutorials/prepare_ligand/prepare_ligand_tutorial)

### Constraint file 

See [Matching and enzyme design geometric constraint file format](https://www.rosettacommons.org/docs/latest/rosetta_basics/file_types/match-cstfile-format) for details.
Example file format (Note lines start with # are commented out, you can add them back in as needed. Multiple blocks are needed if you can more than one constraint):
```
CST::BEGIN
  TEMPLATE::   ATOM_MAP: 1 atom_name: MG3 O5 P1
  TEMPLATE::   ATOM_MAP: 1 residue3:  X00
	
  TEMPLATE::   ATOM_MAP: 2 atom_name: OD2 CG CB
  TEMPLATE::   ATOM_MAP: 2 residue1:  D
	
  CONSTRAINT:: distanceAB:    2.5   0.3    500 0    3
# CONSTRAINT::    angle_A:   65.8   6.5    50  360. 2
  CONSTRAINT::    angle_B:  145.3  20.0    50  360. 2
# CONSTRAINT::  torsion_A:   83.6  10.0    50  360. 2
  CONSTRAINT:: torsion_AB:  128.7  20.0    50  360. 2
# CONSTRAINT::  torsion_B:  141.0  15.0    50  360. 2
```

### Flags file

See [This link](https://www.rosettacommons.org/docs/latest/development_documentation/code_structure/namespaces/namespace-utility-options#flagsfile) for details about how to write flags file.
An example file looks like this:
```
-score::weights ref2015.wts
-in
 -file
  -s 4xlx_wlig_1.pdb
  -extra_res_fa X00.params
  -extra_res_fa Y00.params
-out
 -file
 -overwrite	
-packing
 -ex1
 -ex1aro
 -ex2
-packing::ex1aro:level 6
-packing::ex2aro
-packing::extrachi_cutoff 1
-packing::use_input_sc
-packing::unboundrot 4xlx_wlig_1.pdb
-packing::flip_HNQ
-packing::no_optH false

-enzdes::minimize_all_ligand_torsions 5.0
-enzdes::bb_min_allowed_dev 0.5
-enzdes::cstfile dock.cst

-run::preserve_header
-run:version
-nblist_autoupdate
-linmem_ig 10
-database /share/siegellab/tiffy/rosetta_bin_linux_2018.09.60072_bundle/main/database/

-jd2::enzdes_out

-mute core.util.prof ## dont show timing info
-mute core.io.database
```

### XML file

XML Script can be found here: https://github.com/RosettaCommons/rosetta_scripts_scripts/blob/master/scripts/public/docking/terpeneSynthase_docking.xml.

Run Calculation 
========
To run the docking calculation, do 
```
Rosetta/Path/main/source/bin/rosetta_scripts.default.linuxgccrelease @flags  -parser:protocol XMLfile.xml -nstruct nstruct_number
```

References
========
Methodology paper:

[Predicting Productive Binding Modes for Substrates and Carbocation Intermediates in Terpene Synthases—Bornyl Diphosphate Synthase As a Representative Case](https://pubs.acs.org/doi/abs/10.1021/acscatal.8b00342)

Terrence E. O’Brien, Steven J. Bertolani, Yue Zhang, Justin B. Siegel Dean J. Tantillo

Docking with three ligands:

[Switching on a Nontraditional Enzymatic Base—Deprotonation by Serine in the ent-Kaurene Synthase from Bradyrhizobium japonicum](https://pubs.acs.org/doi/abs/10.1021/acscatal.9b02783)

Meirong Jia, Yue Zhang, Justin B. Siegel, Dean J. Tantillo, Reuben J. Peters

Other examples:

[Mechanistically informed predictions of binding modes for carbocation intermediates of a sesquiterpene synthase reaction](https://pubs.rsc.org/en/content/articlehtml/2016/sc/c6sc00635c)

T. E. O'Brien, S. J. Bertolani, D. J. Tantillo and J. B. Siegel

##See Also
* [Ligand Docking Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/ligand_docking/ligand_docking_tutorial)
* [[RosettaScripts]]: Homepage for the RosettaScripts interface to Rosetta


