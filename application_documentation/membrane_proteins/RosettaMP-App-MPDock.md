# RosettaMP Application: Membrane Protein-Protein Docking (MPDock)

## Code and Demo
The executable for MPDock can be found in `Rosetta/main/source/src/apps/public/membrane/mp_dock.cc`

A demo for this application can be found in `Rosetta/demos/protocol_captures/mp_dock`

Rosetta Revision #58096

## Algorithm Description
Structure determination of protein-protein complexes in the membrane bilayer is extraordinarily difficult due to the requirement for the membrane mimetic to maintain stability of the complex and because many complexes exceed the molecular weight limit for NMR spectroscopy. We combined RosettaMP with the RosettaDock algorithm to predict structures of protein-protein complexes in the membrane bilayer. The protocol consists of two steps: (1) a prepacking step to create a starting structure, and (2) protein-protein docking in the membrane bilayer. In the pre-packing step, the two partners are first separated by a large distance (keeping their membrane embedding constant), the side chains are repacked using rotamer trials, and the partners are moved back together. Next, the docking step samples random interface conformations using a score function that is created by combining the standard docking score functions with the membrane score terms (both in the low-resolution and all-atom stages). The membrane bilayer is kept fixed during this simulation. 

Be aware that the current protocol is set up to do a local docking run only. Implementation of a global docking protocol is currently underway.

## Generating Inputs

1. download a PDB structure from PDBTM 
2. clean the PDB file using the clean_pdb.py script in Rosetta/tools/protein_tools/scripts 
4. remove any chains in solution or chains that would hinder docking
3. generate a spanfile using the span_from_PDB application described in the Rosetta/demos/protocol_captures/2015/MP_span_from_PDB directory

## Prepacking step

```
Rosetta/main/source/bin/docking_prepack_protocol.linuxgccrelease
-in:file:s 1AFO_AB.pdb	                        # Starting structure containing both partners
-score:weights mpframework_docking_fa_2015.wts	# Use mpdocking score function
-mp:setup:spanfiles 1AFO_AB.span	        # Predicted TM Spans
-mp:scoring:hbond	                        # Membrane hydrogen bonding weight
-packing:pack_missing_sidechains 0	        # Wait to pack sidechains until membrane is present
-partners A_B                                   # Specify the two docking partners by chain
```

Generate 10 structures with the prepacking step and pick the one with the lowest total Rosetta score.

## Docking run

```
Rosetta/main/source/bin/mp_dock.linuxgccrelease 
-in:file:s 1AFO_AB_ppk.pdb	                # Pre-packed input structure
-in:file:native 1AFO_AB.pdb	                # Native structure for RMSD calculations
-score:weights mpframework_docking_fa_2015.wts	# Score function
-mp:setup:spanfiles 1AFO_AB.span	        # Predicted TM spans
-mp:scoring:hbond	                        # Membrane hydrogen bonding weight
-docking:partners A_B	                        # Partners to dock
-docking:dock_pert 3 8	                        # Magnitude of perturbation
-packing:pack_missing_sidechains 0	        # Wait to pack sidechains until membrane is present

```

Generate at least 1000 models and analyze the data using interface score vs. RMSD plots. 

## Tips

If the interface score doesn't show up in the scorefile and you want to add it, you can use the flag ```-score:docking_interface_score 1 ```


## References
* Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press 

* Gray, J. J.; Moughon, S.; Wang, C.; Schueler-Furman, O.; Kuhlman, B.; Rohl, C. A.; Baker, D., Protein-protein docking with simultaneous optimization of rigid-body displacement and side-chain conformations. Journal of Molecular Biology 2003, 331, (1), 281-299.

* Chaudhury, S., Berrondo, M., Weitzner, B. D., Muthu, P., Bergman, H., Gray, J. J.; Benchmarking and analysis of protein docking performance in RosettaDock v3.2., PLoS One. 2011;6(8):e22477


## Contact

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))
