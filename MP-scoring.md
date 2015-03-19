## Metadata

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 3/17/15

## Citation
Rosetta Revision #57518

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Elazar A, Tilley DC, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design
PLoS Computational Biology (under revision) 

## Algorithm Description
Scoring a membrane protein pose with a defined score function is one of the most basic and much needed functionality. For this, we hijacked the score_jd2 application and made it (at least partly) applicable for membrane proteins. 

## Code and Demo
This application uses Movers from RosettaMP. The score_jd2 application can be found at `public/analysis/score_jd2.cc`. The supplement of the above manuscript also outlines its use. 

## Run the application

There are two modes available for this application: 

1. Having a fixed membrane and a fixed protein. This requires the protein structure already be transformed into membrane coordinates (see [https://www.rosettacommons.org/docs/wiki/PDB-file](https://www.rosettacommons.org/docs/wiki/PDB-file) on how to do this) and currently only works if a spanfile is given, which can be generated from the transformed structure (see XXX). 

```
Rosetta/main/source/bin/score_jd2.macosclangdebug \
-database Rosetta/main/database \
-in:file:s 1AFO_tr.pdb \
-in:membrane \
-mp:setup:spanfiles 1AFO__tr.span \
-mp:setup:transform_into_membrane \
-score:weights mpframework_smooth_fa_2012.wts \
```




1. download a PDB structure from PDBTM 
2. clean the PDB file using the clean_pdb.py script in Rosetta/tools/protein_tools/scripts 
4. remove any chains in solution or chains that would hinder docking
3. generate a spanfile using the span_from_PDB application described in the Rosetta/demos/protocol_captures/2015/MP_span_from_PDB directory

## Prepacking step

```
Rosetta/main/source/bin/docking_prepack_protocol.linuxgccrelease
-in:file:s 1AFO_AB.pdb	                        # Starting structure containing both partners
-score:weights mpframework_docking_fa_2014.wts	# Use mpdocking score function
-mp:setup:spanfiles 1AFO_AB.span	        # Predicted TM Spans
-mp:scoring:hbond	                        # Membrane hydrogen bonding weight
-packing:pack_missing_sidechains 0	        # Wait to pack sidechains until membrane is present
```

Generate 10 structures with the prepacking step and pick the one with the lowest total Rosetta score.

## Docking run

```
Rosetta/main/source/bin/mpdocking.linuxgccrelease 
-in:file:s 1AFO_AB_ppk.pdb	                # Pre-packed input structure
-in:file:native 1AFO_AB.pdb	                # Native structure for RMSD calculations
-score:weights mpframework_docking_fa_2014.wts	# Score function
-mp:setup:spanfiles 1AFO_AB.span	        # Predicted TM spans
-mp:scoring:hbond	                        # Membrane hydrogen bonding weight
-docking:partners A_B	                        # Partners to dock
-docking:dock_pert 3 8	                        # Magnitude of perturbation
-packing:pack_missing_sidechains 0	        # Wait to pack sidechains until membrane is present

```


