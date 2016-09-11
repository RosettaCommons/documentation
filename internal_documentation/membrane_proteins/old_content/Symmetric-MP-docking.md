## Metadata

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 2/17/15

## Citation
Rosetta Revision #57518

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Elazar A, Tilley DC, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design
PLoS ONE (in preparation) 

## About
Many membrane proteins assemble into symmetric complexes in the membrane environment. We developed an application for symmetric assembly of complexes in the membrane bilayer; we achieved this by combining Rosetta’s symmetric docking protocol [48,49] with RosettaMP.

## Code and Demo
This application uses RosettaMP. Detailed information of how to run it can be found in the manuscript and in Rosetta/demos/protocol_captures/2015/mp_symdock. 

## Generating Inputs

1. download a PDB structure from PDBTM 
2. clean the PDB file using the clean_pdb.py script in Rosetta/tools/protein_tools/scripts 
4. remove any chains in solution or chains that would hinder docking
3. generate a spanfile using the span_from_PDB application described in the Rosetta/demos/protocol_captures/2015/MP_span_from_PDB directory

## Command lines

To resolve initial clashes in the crystal structure, the native was refined using the MPrelax application . The following application and flags were used. Here, 1afo is used as an example: 

```
Rosetta/main/source/bin/rosetta_scripts.linuxgccdebug
-parser:protocol membrane_relax.xml   # Path to Rosetta script (above)
-in:file:s 1afo_native.pdb            # Input structure
-nstruct 10                           # Generate 10 models
-mp:setup:spanfiles 1afo.span         # Predicted TM Spans
-mp:scoring:hbond                     # Membrane hydrogen bonding weight
-relax:jump_move true                 # Allow jumps to move during relax
-packing:pack_missing_sidechains 0    # Wait to pack sidechains until membrane is present
```

10 refined native complexes were generated and the model with the lowest total Rosetta score was used as the starting structure for symmetric docking. From this starting structure, a symmetry definition file describing the arrangement of subunits around the C symmetry axis and input structure containing the asymmetric subunit was generated with the following script and options: 

```
Rosetta/main/source/src/apps/public/symmetry/make_symmdef_file.pl > 1afo.c2.symm
-p 1afo_native.pdb  # Refined symmetric complex as input
-a A                # Chain to use as the master subunit 
-b B:2              # 1st child subunit (B) and number of subunits in the symmetric complex (2)
```
	
It is important to note that this script requires all chains be of equal length. The output file contains the symmetry definition required for symmetric modeling in Rosetta. 

Because the starting structure was already transformed into the membrane coordinate frame (since the transformed file was downloaded from PDBTM), spanfiles were generated using the span_from_pdb application described below. Predicted TM spans are only provided as input for the asymmetric starting unit. 

The following application and flags were used to generate models of the symmetric complex: 

```
Rosetta/main/source/bin/membrane_symdocking.linuxgccdebug
-in:file:s 1afo_input.pdb                     # Asymmetric input structure
-in:file:native 1afo_tr_native.pdb            # Native structure for RMSD calculations
-mp:setup:spanfiles 1afo.span                 # Predicted TM spans for asymm unit
-mp:scoring:hbond                             # Membrane hydrogen bonding weight
-symmetry:symmetry_definition 1afo.c2.symm    # Symmetry definition file
-symmetry:initialize_rigid_body_dofs          # Sample configurations during assembly
-packing:pack_missing_sidechains 0            # Wait to pack sidechains until membrane is present
-docking:dock_lowres_filter 5.0 10.0          # Change filters required for a low
                                              # resolution model to advance to 
                                              # high-res stage. Vdw score < 5.0 and
                                              # interchain contact score < 10.0
```

Score vs. RMSD plots were generated from the output score file. RMSDs of the assembled complex are computed with respect to the backbone atoms of the native structure. 

## References
* André I, Bradley P, Wang C, Baker D. Prediction of the structure of symmetrical protein assemblies. Proc Natl Acad Sci. 2007;104: 17656–17661. doi:10.1073/pnas.0702626104
* DiMaio F, Leaver-Fay A, Bradley P, Baker D, André I. Modeling Symmetric Macromolecular Structures in Rosetta3. PLoS ONE. 2011;6: e20450. doi:10.1371/journal.pone.0020450

