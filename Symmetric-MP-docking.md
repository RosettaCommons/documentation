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
This application uses RosettaMP. Detailed information of how to run it can be found in Rosetta/demos/protocol_captures/2015/mpdocking. 

## Generating Inputs

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

Generate at least 1000 models and analyze the data using interface score vs. RMSD plots. 

## References
* Gray, J. J.; Moughon, S.; Wang, C.; Schueler-Furman, O.; Kuhlman, B.; Rohl, C. A.; Baker, D., Protein-protein docking with simultaneous optimization of rigid-body displacement and side-chain conformations. Journal of Molecular Biology 2003, 331, (1), 281-299.
* Chaudhury, S., Berrondo, M., Weitzner, B. D., Muthu, P., Bergman, H., Gray, J. J.; Benchmarking and analysis of protein docking performance in RosettaDock v3.2., PLoS One. 2011;6(8):e22477
