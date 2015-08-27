#Mg(2+) modeling
==================================

Application purpose
===========================================

This code models Mg2+ ions into structures, including waters for hexahydrates. It has several modes, ranging from orienting the 'orbitals' for an existing Mg(2+) that define its hexhydrate shell all the way to docking Mg(2+) (and associated waters) _de novo_ into the structure.


Algorithm
=========

The current implementation of Mg(2+) docking is based on an enumerative grid search. 

Modeling of the hydration shell involves placement of 6 virtual atoms marking the faces of a 2 Å cube with the Mg(2+) at its center. These atoms mark 'orbital' or 'ligand field' positions where the six waters might go. Orientation  of these virtual atoms and then placement/removal of waters near those positions has been accelerated through heuristics that reproduce enumerative search of those degrees of freedom.

Score functions have been developed for both the explicit water and implicit water case. The latter allows for water-mediated contacts of Mg(2+) to acceptor atoms. See section below on Scorefunction.



Limitations
===========

-   These methods' predictive power have not yet been well tested. These classes should be easy to incorporate into structure prediction & design methods, such as the [[fragment assembly|rna-denovo-setup]] or [[stepwise]] frameworks.  The application is being made public to encourage others inside and outside the Rosetta community to contact developers if they have compelling use cases for _de novo_ Mg(2+) modeling, e.g., in docking Mg(2+) into experimental structures or designing ion binding sites into catalytic sites.

-   Basic calibration of the weights on the score terms has not been carried out (see below for descriptions).

-   It seems likely that incorporation of solutions to the nonlinear Poisson-Boltzman equation, which models regions of high electrostatic potential due to long-range effects, would complement the current code, which (in classic Rosetta style).

References
==========
This work is unpublished. Please contact rhiju [at] stanford.edu for information about citing or extending Rosetta Mg(2+) modeling.


Code and Demo
=============

The main code is available in the `mg_modeler` executable, with source code in `src/apps/public/magnesium/mg_modeler.cc`. 

This application is basically a simple wrapper around the classes `MgScanner` and `MgMonteCarlo`, which should be easy to reuse in new applications for prediction and design.

Test files and example command lines are available in integration tests:

```
       main/tests/integration/tests/mg_modeler      
       main/tests/integration/tests/mg_modeler_lores
```      



Input Files
===========

You need a starting structure to run the modeling, in PDB format. It can contain Mg(2+) already to serve as reference locations or positions from which to perturb. Or it can have no Mg(2+) ions if you are trying to dock Mg(2+) _de novo_.

How to dock a Mg(2+)
====================
This is the main mode of use of mg_modeler.
Example command-line (available in the integration test; see path above):

```
mg_modeler -s arich_2r8s_RNA.pdb -out:file:silent arich_mg_hydrate.out -score:weights test_hires2.wts -pose_ligand_res 8
```

This reads in `arich_2r8s_RNA.pdb` which holds the RNA 'metal ion core' in the A-rich bulge region of the P4-P6 domain of the _Tetrahymena_ group I ribozyme. Mg(2+) positions that are within direct contact distance to any electronegative atom (h-bond acceptor) of residue 8 (specified in `-pose_ligand_res`) are tested. Output locations that pass default score filters go to a silent file of the RNA with the Mg(2+) and any waters (specified in `-out:file:silent`). 

Models can be extracted from the silent file into PDB format with the usual extraction utilities (see extract_lowscore_decoys.py in [[rna-denovo-setup]] or [[extract_pdbs]).

Note that during the scan, the two Mg(2+) ions inside the input PDB are stripped out (they can be kept if user supplied `-mg_res`). Their positions are still used to return RMSD values (computed as the deviation of the modeled Mg(2+) position from the closest Mg(2+) in the reference structure).

Other modes
====================
Rather than dock ('scan') a Mg(2+)  into the structure, `mg_modeler` allows access to three of the `MgScanner`'s component functionalities, mainly for testing, as well as a (rather untested) pilot mode for carrying out monte carlo sampling of the Mg(2+) and associated waters.

Component Mode 1. Orient Mg(2+) ligand-field ('orbital') frames
------------------------------------------------------


Component Mode 2. Pack hydrogens in existing waters that ligate Mg(2+)
--------------------------------------------------------

Component Mode 3. Pack waters around existing Mg(2+)
------------------------------------------

Alternative Sampling Mode. Sample Mg(2+) & water position by monte carlo.
-------------------------------------------------------




Summary of Options
===================
Some useful options for `mg_modeler`

```
Required:
-s                        Input PDB structure
-out:file:silent          Silent file for output

Commonly used options:
-ligand_res               in scan, look at positions near these residues (PDB numbering/chains)
   OR                       (If unspecified, search near all residues as potential ligands.)
-pose_ligand_res          similar to -ligand_res, but use pose numbering (1,2,..)
-mg_res                   supply PDB residue numbers of Mg(2+) to look at [leave blank to scan a new Mg(2+)]

Alternative modes
-lores_scan               do not try hydration or minimization during scan [works well
                             with mg_point and mg_point_indirect score terms]
-fixup                    align the 6 octahedral virtual  'orbitals' for Mg(2+) specified by mg_res
          pack_water_hydrogens |                     false |   B| test mode: strip out non-mg 
                               |                           |    |  waters, align mg frames, 
                               |                           |    |  pack mg waters for 
                               |                           |    |  specified mg_res
                       hydrate |                     false |   B| test mode: strip out waters 
                               |                           |    |  and hydrate mg(2+) for 
                               |                           |    |  specified mg_res
                   monte_carlo |                     false |   B| test mode: monte carlo 
                               |                           |    |  sampling of Mg(2+) and 
                               |                           |    |  surrounding waters

Advanced options
       minimize_during_scoring |                           |   B| minimize mg(2+) during 
                               |                           |    |  scoring/hydration of each 
                               |                           |    |  position (true)
                      xyz_step |                       0.5 |   R| increment in Angstroms for 
                               |                           |    |  xyz scan
                     score_cut |                         5 |   R| score cut for silent output 
                               |                           |    |  (5.0 for hires; -8.0 for 
                               |                           |    |  lores)
                 score_cut_PDB |                         0 |   R| score cut for PDB output 
                               |                           |    |  from scanning (deprecated)
              integration_test |                     false |   B| Stop after first mg position 
                               |                           |    |  found -- for testing
         tether_to_closest_res |                     false |   B| stay near closest ligand 
                               |                           |    |  res; helps force unique 
                               |                           |    |  grid sampling in different 
                               |                           |    |  cluster jobs.

      scored_hydrogen_sampling |                     false |   B| in -pack_water_hydrogens 
                               |                           |    |  test mode, when packing 
                               |                           |    |  water hydrogens, use a 
                               |                           |    |  complete scorefunction to 
                               |                           |    |  rank (slow)
          all_hydration_frames |                     false |   B| in -hydration test mode, 
                               |                           |    |  Sample all hydration 
                               |                           |    |  frames (slow)
            leave_other_waters |                     false |   B| in -hydration test mode, do 
                               |                           |    |  not remove all waters
                      minimize |                     false |   B| minimize Mg(2+) after 
                               |                           |    |  hydration or 
                               |                           |    |  hydrogen-packing
minimize_mg_coord_constraint_distance |                0.2 |   R| harmonic tether to Mg(2+) 
                               |                           |    |  during minimize
                               |                           |    |
       magnesium:montecarlo:   |                           |    | 
                   temperature |                         1 |   R| temperature for Monte Carlo
                        cycles |                    100000 |   I| Monte Carlo cycles
                          dump |                     false |   B| dump PDBs from Mg monte carlo
          add_delete_frequency |                       0.1 |   R| add_delete_frequency for 
                               |                           |    |  Monte Carlo


Required:
-sequence                sequence supplied directly [string]
  OR
-fasta                   Fasta-formatted sequence file -- but concatenate all RNA chains in one sequence!

Commonly used options
-secstruct               secondary structure in dot-parentheses notation (enclose in quotes)
 OR
-secstruct_file          file containint secondary structure on top line (can have sequence or anything else on later lines)
-offset                  integer specifying how much to add to each sequence position to get conventional numbering (default: 0)
-cutpoint_open           positions of any strand breaks
-working_res             which residues to model in the desired sub-problem (example: '122-135 166-190', default is all res.)
-fixed_stems             set up de novo modeling fold tree so that helices are connected by rigid-body transforms (default:false, but now recommended)
-s                       list of PDB files to use; must have residue numbers corresponding to location in full modeling problem (default: no input files)

Less commonly used options, but useful
-nstruct                 number of structures for each FARFAR denovo modeling run to produce (default: 500)
-tag                     string to put in front of all input files and final output file (default: name of working directory)
-native_pdb              file with reference PDB for RMSD values (optional)

Advanced options
-out_script              name of output script with Rosetta command line (default: "README_FARFAR")
-silent                  any *input* Rosetta silent files with multiple options for a subset of residues
-input_silent_res        residue numbers that go with the silent files
-no_minimize             do not carry out full-atom refinement, just fragment assembly under lo res score function.
-working_native_pdb      supply a reference PDB file that has just working_res only.
-cst_file                constraint file in old 'section-based' Rosetta constraint format
-data_file               data file with, e.g., DMS data in 'DMS position value' format, or in RDAT format.
-cutpoint_closed         specify that transient chain breaks occur at specific positions, rather than chosen randomly at loops
-extra_minimize_res      positions that may be in input residues (specified in -s or -silent) but should be minimized
-extra_minimize_chi_res  positions that may be in input residues (specified in -s or -silent) but side-chains should be minimized
-virtual_anchor          poorly named; creates a virtual anchor necessary for rigid-body sampling of separate parts of the pose
-obligate_pair           specify pairs of positions that must be in base pairs (perhaps at the expense of transient chain breaks elsewhere)
-obligate_pair_explicit  like obligate pair, but specify sets of 5: <pos1> <pos2> <W/H/S> <W/H/S> <A/P>, where W/H/S means Watson-Crick/Hoogsteen/sugar edge; and A/P means antiparallel/parallel base normals.  
-chain_connection        specify that pairings must occur between two sets of residues: SET1 <positions in set 1> SET2 <positions in set 2>
```


##See Also

* [[RNA Denovo]]: The main rna_denovo application page
* [[RNA applications]]: The RNA applications home page
* [[Structure Prediction Applications]]: List of structure prediction applications
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Application Documentation]]: Home page for application documentation
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files