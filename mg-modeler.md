#Mg(2+) modeling
==================================

Application purpose
===========================================

This code models Mg(2+) ions into structures, including waters for hexahydrates. It has several modes, ranging from orienting the 'orbitals' for an existing Mg(2+) that define its hexahydrate shell all the way to docking Mg(2+) (and associated waters) _de novo_ into the structure.

Click on the link below to watch a movie of the water packing as a Mg(2+) shoots through a structure:

[![Mg trajectory through an RNA, with packing of waters](http://img.youtube.com/vi/SRsyG85Jvsc/0.jpg)](http://www.youtube.com/watch?v=SRsyG85Jvsc)


Algorithm
=========

The current implementation of Mg(2+) docking is based on an enumerative grid search. 

Modeling of the hydration shell involves placement of 6 virtual atoms marking the faces of a 2 Å cube with the Mg(2+) at its center. These atoms mark 'orbital' or 'ligand field' positions where the six waters might go. Orientation  of these virtual atoms and then placement/removal of waters near those positions has been accelerated through heuristics that reproduce enumerative search of those degrees of freedom.

Score functions have been developed for both the explicit water and implicit water case. The latter allows for water-mediated contacts of Mg(2+) to acceptor atoms. See section below on Scorefunction.


Limitations
===========

-   These methods' predictive power have not yet been well tested. These classes should be easy to incorporate into structure prediction & design methods, such as the [[fragment assembly|rna-denovo-setup]] or [[stepwise]] frameworks.  The application is being made public to encourage others inside and outside the Rosetta community to contact developers if they have compelling use cases for _de novo_ Mg(2+) modeling, e.g., in docking Mg(2+) into experimental structures or designing ion binding sites into catalytic sites.

-   Basic calibration of the weights on the score terms has not been carried out (see below for descriptions).

-   It seems likely that incorporation of solutions to the nonlinear Poisson-Boltzmann equation, which models regions of high electrostatic potential due to long-range effects, would complement the current code, which (in classic Rosetta style).

-   Haven't yet tested on proteins or RNA/protein interfaces, though the code should not have (too many) hard-coded RNA-specific things.

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

Models can be extracted from the silent file into PDB format with the usual extraction utilities (see extract_lowscore_decoys.py in [[rna-denovo-setup]] or [[extract_pdbs]]).

Note that during the scan, the two Mg(2+) ions inside the input PDB are stripped out (they can be kept if user supplied `-mg_res`). Their positions are still used to return RMSD values (computed as the deviation of the modeled Mg(2+) position from the closest Mg(2+) in the reference structure).

The movie at the top of the page shows what happens at each grid position during the docking, but the Mg(2+) is scanned along a toy linear trajectory for ease of visualization. (Also, the movie does not show the minimization steps.)

Other modes
====================
Rather than dock ('scan') a Mg(2+)  into the structure, `mg_modeler` allows access to three of the `MgScanner`'s component functionalities, mainly for testing, as well as a (rather untested) pilot mode for carrying out monte carlo sampling of the Mg(2+) and associated waters.

####Component Mode 1. Orient Mg(2+) ligand-field ('orbital') frames
Figure out where the virtual atoms should go around the Mg(2+), and output them as V1, V2, ... V6.
```
mg_modeler -fixup  -s 2R8S.pdb   -ignore_unrecognized_res -output_virtual
```
For this example, can just use `2R8S.pdb` from the PDB. Output is in `2R8S.mg_fixup.pdb`.

####Component Mode 2. Pack hydrogens in existing waters that ligate Mg(2+)
Figure out where hydrogen should go in water contacting Mg(2+).
```
mg_modeler -pack_water_hydrogens  -s 2R8S.pdb   -ignore_unrecognized_res -output_virtual
```
Waters not contacting Mg(2+) are stripped out. Output is in `2R8S.pack_water_hydrogens.pdb`.

Extra flag `-scored_hydrogen_sampling` actually rotates water through all possible orientations (via Hopf fibration of SO(3), removing dihedral-symmetry-related orientations; see `numeric/UniformRotationSampler.hh`) to find best position by brute-force, and picks best orientation by some scorefunction. The default heuristic actually does just as good a job in terms of finding sensible hydrogens.

####Component Mode 3. Pack waters around existing Mg(2+)
Figure out where waters should be around each Mg(2+):
```
mg_modeler -hydrate  -s 2R8S.pdb   -ignore_unrecognized_res -output_virtual
```
Strips out any waters from the PDB before doing the hydration. Output is in `2R8S.hydrate.pdb`. 

Extra flags '-all_hydration_frames' does brute force search over all octahedral frames for the waters. Again, uses Hopf fibration of SO(3), removing octahedral-symmetry-related orientations, and some Rosetta scorefunction, very slow. Again, the default heuristic searches over a more limited subset of octahedral frames and seems to do just as good a job of figuring out water placement.

####Alternative Sampling Mode. Sample Mg(2+) & water position by monte carlo.

Was testing a mode where waters might be placed through monte carlo sampling, including add/delete moves for waters. Example command line:
```
time mg_modeler -monte_carlo -s mg.pdb -mute core -temperature 0.7 -constant_seed -output_virtual -cycles 10000  
```
where `mg.pdb` has a single Mg(2+) at the origin. Left this mode in there for kicks -- movie looks like a 'water fountain':

[![Mg water fountain](http://img.youtube.com/vi/zF0czzuurOI/0.jpg)](http://www.youtube.com/watch?v=zF0czzuurOI)

Probably could expand this mode to sample Mg and waters bumbling around a structure – could eventually be useful for thermal sampling, etc -- but right now a lot of stuff is hardcoded (including, I think, that there is one Mg(2+) at the origin!).


Summary of Options
===================
Some useful options for `mg_modeler`

```
Required:
-s                          Input PDB structure

Commonly used options:
-out:file:silent            silent file for output
-ligand_res                 in scan, look at positions near these residues 
                              (PDB numbering/chains)
   OR                         (If unspecified, search near all residues as 
                               potential ligands.)
-pose_ligand_res            similar to -ligand_res, but use pose number-
                               ing (1,2,..)
-mg_res                     supply PDB residue numbers of Mg(2+) to look 
                               at [leave blank to scan a new Mg(2+)]

Alternative modes
-lores_scan                 do not try hydration or minimization during scan 
                               [good for mg_point, mg_point_indirect score terms]
-fixup                      align the 6 octahedral virtual  'orbitals' for Mg(2+) 
                                specified by mg_res
-pack_water_hydrogens       test mode: strip out non-mg waters, align mg frames, 
                               pack mg waters for specified mg_res
-hydrate                    test mode: strip out waters and hydrate mg(2+) 
                               for specified mg_res
-monte_carlo                test mode: monte carlo sampling of Mg(2+) and 
                               surrounding waters

Advanced options
-minimize_during_scoring    minimize mg(2+) during scoring/hydration of each 
                              position (default: true)
-xyz_step                   increment in Angstroms for xyz scan (default 0.5)
-score_cut                  score cut for silent output (default 5.0 for hires; 
                              -8.0 for lores)
-integration_test           stop after first mg position found -- for testing
-tether_to_closest_res      stay near closest ligand res; helps force unique grid 
                              sampling in different cluster jobs.
-scored_hydrogen_sampling   in -pack_water_hydrogens  test mode, when packing 
                              water hydrogens, use a complete scorefunction 
                              to rank (slow)
-all_hydration_frames       in -hydration test mode, sample all hydration 
                               frames (slow)
-leave_other_waters         in -hydration test mode, do not remove all waters
-minimize                   in -hydration test mode, minimize Mg(2+) after 
                               hydration or hydrogen-packing
-minimize_mg_coord_constraint_distance 
                            harmonic tether to Mg(2+) during minimize (default: 
                               0.2 Angstroms)

Totally advanced options for a mode that is basically untested
-magnesium:montecarlo:temperature     temperature for Monte Carlo (default 
                                        1.0)
-magnesium:montecarlo:cycles          Monte Carlo cycles (default 100000)
-magnesium:montecarlo:dump            dump PDBs from Mg monte carlo (to make 
                                        movies)
-magnesium:montecarlo:add_delete_frequency   
                                      add_delete_frequency for Monte Carlo 
                                        (default 0.1)

```

Scorefunctions (in development)
===============================
Two sets of scorefunctions are in use.

### `test_lores.wts` 
Contains some mg lores terms (originally developed in 2012):
```
rna_mg_point          1.0  # contains distance and angle dependent 
                           #   terms for Mg(2+) interacting with hydrogen-bond acceptors
                           #   based on fits to Mg-RNA PDB structures.

rna_mg_point_indirect 1.0  # contains longer-range water-mediated 
                           #   interactions with hydrogen-bond acceptors.
                           #   only distance-dependence in this case. again, based 
                           #   on unpublished fits to Mg-RNA PDB structures

fa_rep                1.0  # prevent clashes of mg(2+) with stuff
geom_sol_fast         0.3  # prevents mg(2+) from occluding polar groups (particularly electropositive groups)
lk_nonpolar           0.3  # probably doesn't do much
NO_HB_ENV_DEP
```
The derivatives of these terms have not been implemented, but that would be easy to do, based on how they were set up for the hires mg terms (see next).

### `test_hires2.wts` 
Contains mg hires terms:
```
fa_rep        0.21 # standard
fa_atr        0.20 # standard
geom_sol_fast 0.17 # standard

mg_lig        1.0 # direct interaction of Mg2+ with hydrogen bond acceptors
mg_sol        0.2 # isotropic solvation penalty for atoms occluding the Mg(2+) -- double counting with explicit water?
mg_ref        1.0 # cost of instantiating Mg(2+) (can yet modulatable by -mg_conc)
hoh_ref       3.0 # cost of instantiating explicit water

hbond_sc      1.0 # standard

NO_HB_ENV_DEP         # standard (for RNA at least)
ENLARGE_H_LJ_WDEPTH   # standard (for RNA at least)
```

More information on these terms is in header of `src/core/scoring/magnesium/MgEnergy.cc`:
```
//
// Enforces Mg(2+) to have 6 octahedrally coordinated ligands.
//
// Octahedral axes ('orbital frame' or 'ligand field') defined by
//  perpendicular virtual atoms V1, V2, V3, V4, V5, V6:
//
//        V2 V6
//         |/
//   V4 -- Mg -- V1
//        /|
//      V3 V5
//
// Basic interaction potential mg_lig is defined in terms of three geometric parameters:
//
//                 Base
//                 /
//   Mg -- V   :Acc
//
//   1.  Dist(  Mg -- Acc )         [should be near 2.1 Angstroms]
//   2.  Angle( Acc -- Mg -- V)     [should be near 0.0; cos angle should be near +1.0]
//   3.  Angle( Mg -- Acc -- Base ) [should be near 120-180 degrees; cos angle should be < -0.5]
//
// Also include terms:
//
//   mg_sol  [penalty for blocking fluid water]
//   mg_ref  [cost of instantiating mg(2+); put into ref?]
//   hoh_ref [cost of instantiating water]
//
//              -- rhiju, 2015
//
// Note: for cost of instantiating water, could instead use:
//
//    h2o_intra, [in WaterAdductIntraEnergyCreator -- check if activated]
// OR pointwater [when Frank's PWAT is checked in from branch dimaio/waterstuff.]
//
// will need to make a decision when dust settles on HOH.
//
//
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