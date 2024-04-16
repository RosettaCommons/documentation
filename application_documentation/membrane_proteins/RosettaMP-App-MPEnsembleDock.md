# RosettaMP Application: Membrane Protein-Protein Ensemble Docking (MPEnsembleDock)

## Code and Demo
The executable for MPDock can be found in `Rosetta/main/source/src/apps/public/membrane/mp_dock.cc`å
Rosetta Revision #58096

## Algorithm Description
The MP ensemble docking protocol consists of three steps: (1) the ensemble generation step to diversify the protein backbone, (2) the pre-packing step to refine the side chains and create a starting structure, and (3) the protein-protein docking in the membrane bilayer. Here, we combine the flexible backbone RosettaDock 4.0 protocol for soluble proteins, embed them in the membrane, and use membrane energy functions to rank them. In the ensemble generation step, to generate diversity in backbone conformations for the proteins, we used three conformer generation methods: perturbation of the backbones along the normal modes by $1$\AA [using RosettaScripts], refinement using the Relax protocol in Rosetta, and backbone flexing using the Rosetta Backrub protocol. We have used 40 Backrub conformers, 30 normal mode conformers, and 30 relax conformers to comprise an ensemble of 100 conformers. Similar to the rigid docking, in the pre-packing step, the side chains of the ensembles of the unbound structures (keeping their membrane embedding constant) are repacked using rotamer trials. Next, the docking step uses Monte Carlo and a minimization algorithm consisting of a low-resolution step simulating conformer selection and a high-resolution step simulating induced fit. The low-resolution step includes rotating and translating the ligand around the receptor coupled with swapping of the pre-generated backbone conformations using Adaptive Conformer Selection. In the high-resolution stage, the side chains are reintroduced to the putative encounter complex, and those at the interface are packed for tight binding. There is minimal rigid-body motion in this second stage. At all steps, the membrane is kept fixed. 

## Generating Inputs

1. download a PDB structure from PDBTM 
2. clean the PDB file using the clean_pdb.py script in Rosetta/tools/protein_tools/scripts 
4. remove any chains in solution or chains that would hinder docking
3. generate a spanfile using the span_from_PDB application described in the Rosetta/demos/protocol_captures/2015/MP_span_from_PDB directory

## Ensemble generation step
Relax flag
```
-in:file:s complex_A.pdb
-nstruct 30
-relax:fast
-out:pdb_gz
-out:prefix relax_
-out:path:all output
```
NMA flag
```
-in:file:s complex_A.pdb
-nstruct 30
-parser:protocol nma.xml
-out:prefix nma_
-out:path:all output
```
xml script for nma: 
```
<ROSETTASCRIPTS>
<!-- This protocol mixes motion along the first 5 normal modes with perturbation of 1 A. -->
        <SCOREFXNS>
                <ScoreFunction name="bn15_cart" weights="ref2015_cart"/>
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
        </RESIDUE_SELECTORS>
        <TASKOPERATIONS>
        </TASKOPERATIONS>
        <FILTERS>
        </FILTERS>
        <MOVERS>
                <NormalModeRelax name="nma" 
                        cartesian="true" 
                        centroid="false"
                        scorefxn="bn15_cart"
                        nmodes="5"
                        mix_modes="true"
                        pertscale="1.0"
                        randomselect="false"
                        relaxmode="relax"
                        nsample="20"
                        cartesian_minimize="false"/>
        </MOVERS>
        <APPLY_TO_POSE>
        </APPLY_TO_POSE>
        <PROTOCOLS>
                <Add mover="nma"/>
        </PROTOCOLS>
        <OUTPUT scorefxn="bn15_cart"/>
</ROSETTASCRIPTS>
```
Backrub flags:
```
-in:file:s complex_A.pdb
-nstruct 30
-backrub:ntrials 20000
-backrub:mc_kt 0.6
-out:path:pdb output
-out:prefix br_
-out:pdb_gz
-out:path:score output
```
Complex_A is the monomer A of the complex. Similarly, the ensemble structures must be generated for monomer B. The ensemble structures are kept in folders chainA, chainB respectively. The list of file paths are written in 1ensemble.txt(chain A), 2ensemble.txt(chainB).  
## Prepacking step
```
Rosetta/main/source/bin/docking_prepack_protocol.linuxgccrelease

-in:file:s complex.pdb	                        # Starting structure containing both partners
-in:file:s native.pdb                           #native complex structure
-in:membrane
-score:weights franklin2019	# Use mp score function
-mp:setup:spanfiles complex.span	        # Predicted TM Spans for the complex
-mp:setup:span1 chainA.span #Predicted chainA span
-mp:setup:sepan2 chainB.span #predicted chainB span
-partners A_B                                   # Specify the two docking partners by chain
-ensemble1 1ensemble.txt
-ensemble2 2ensemble.txt
-nstruct 1
-ignore_zero_occupancy false
-ex1
-ex2aro
-out:suffix _ppk
```

Generates one prepack structures for each ensemble structure in teh folders 1chain and 2chain. Additionally, generates 1ensemble.txt.ensemble and 2ensemble.txt.ensemble with the path to the prepacked structures and their low resolution and high resolution scores. 
## Docking run

```
Rosetta/main/source/bin/mp_dock.linuxgccrelease 
-in:file:s complex.pdb	                # Pre-packed input structure
-in:file:native native.pdb	                # Native structure for RMSD calculations
-nstruct 5000 #number of docked structures
-mp:setup:spanfiles complex.span    # Predicted TM spans
-in:membrane
-mp:lipids:has_pore 0
-mp:lipids:composition POPE
-mp:lipids:temperature 35.0
-docking:dock_pert 3 8	                        # Magnitude of perturbation
-ensemble1 1ensemble.txt.ensemble
-ensemble2 2ensemble.txt.ensemble
-docking:partners A_B	                        # Partners to dock
-docking_low_res_score motif_dock_score #set-up for low resolution score function. 
-mh:path:scores_BB_BB Rosetta/main/database/additional_protocol_data/motif_dock/xh_16_
-mh:score:use_ss1 false
-mh:score:use_ss2 false
-mh:score:use_aa1 true
-mh:score:use_aa2 true
-ignore_zero_occupancy false
-ex1
-ex2aro
-score:weights franklin2019     # highres membrane score function
-score:pack_weights franklin2019    # highres membrane score function for packing
-out:path:all highres_output    #output folder
-out:pdb_gz     #zipped output
-out:file:scorefile updated_docking_fa19.sc
-out:suffix _fa19
-run:multiple_processes_writing_to_one_directory
```

Generate at least 5000 models and analyze the data using interface score vs. RMSD plots. 

## Tips

If the interface score doesn't show up in the scorefile and you want to add it, you can use the flag ```-score:docking_interface_score 1 ```


## References
* Harmalkar A*, Samanta R*; Prathima P; Gray J.J.; An expanded benchmark to advance membrane-associated protein docking - In preparation 

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tilley DC, Elazar A, Gray JJ, An Integrated Framework Advancing Membrane Protein Modeling and Design. PLoS Computational Biology 11, 261
e1004398 (2015)

* Marze NA, Roy Burman SS, Sheffler W, Gray JJ, Efficient flexible backbone protein-protein
docking for challenging targets. Bioinformatics 34, 3461–3469 (2018)
## Contact

Questions and comments to: 
 - Ameya Harmalkar ([harmalkar.ameya24@gmail.com](harmalkar.ameya24@gmail.com))
 - Rituparna Samanta ([rituparna@utexas.edu](rituparna@utexas.edu))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

