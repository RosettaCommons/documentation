#Remodeling RNA, RNA/protein, or RNA/ligand crystallographic models with electron density (ERRASER2: Enumerative Real-Space Refinement ASsitted by Electron density under Rosetta... 2)

Metadata
========

Author: Andrew Watkins

Feb. 2020 by Andy Watkins (amw579 [at] stanford.edu).

Code and Demo
=============

The full ERRASER2 pipeline is a single Rosetta application, *erraser2*. It depends on the modern stepwise Monte Carlo code found in `src/protocols/stepwise/monte_carlo/`, the modern electron density scoring function `elec_dens_fast`, and garden variety Cartesian minimization with restraints.


References
==========

None yet -- preprint should be coming in the next six months.

Application purpose
===========================================

This code is used for improving a given RNA crystallographic model and reducing the number of potential errors in the model (which can evaluated by Molprobity), given the constraint of experimental electron density map.

Algorithm
=========

This method pipelines Rosetta full-atom minimization and enumerative stepwise rebuilding for each individual residue to improve a given RNA crystallographic model. The electron density score helps to restrain the model during the modeling.

Limitations
===========

-   Although ERRASER2 can work for complexes with RNA, protein, ligands, or both, it's the RNA and ligands that get resampled -- any other components are held fixed and just contribute to the scoring "environment" of the components that can be resampled. Furthermore, we can't produce _ad hoc_ torsional potentials for, e.g., chemically modified nucleotides with additional chi angles; any conformational preferences will have to be read out through existing Rosetta one- and two-body energies scores and correspondence to the electron density.

-   Currently crystal contacts are not being modeled, which is known to cause problems in a few test cases when RNA is interacting strongly with its crystal-packing partner (ex. base-pairing and base-stacking). Right now this problem can be resolved by manually adding the crystal-packing partner into the starting PDB file under consideration.

-   To point out a limitation that has been _resolved_, unlike [[ERRASER]], the PHENIX refinement package is not required.

Modes
=====

There is only one mode to run ERRASER2 at present.

Input Files
===========

Required files
-------------

You need two files:

-   The starting structure in standard PDB format; no pre-processing is required.

-   A CCP4 electron density map file. This can be created by PHENIX or other refinement packages. The input map must be a CCP4 2mFo-DFc map. To avoid overfitting, Rfree reflections should be excluded during the creation of the map file.

Optional additional files:
--------------------------

-   No extra optional file is needed for ERRASER.

How to run the job
------------------

ERRASER can be run with the invocation

```
erraser2 -s 1U8D_cut.pdb -edensity:mapfile 1U8D_cell.ccp4 -fasta fasta.txt @ flags
```

The first three arguments are required – the input pdb file, the CCP4 map file, and a specially formatted fasta file that includes residue chain/numbering information. For example, for the tRNA-Cys + EF-Tu complex 1B23, the fasta might look like:

```
>1b23.pdb  R:1-16 R:18-46 R:48-76
ggcgcguX[4SU]aacaaagcggX[H2U]X[H2U]auguagcggaX[PSU]ugcaX[MIA]aX[PSU]ccgucuaguccggX[5MU]X[PSU]cgacuccggaacgcgccucca

>1b23.pdb  P:1-405
AKGEFIRTKPHVNVGTIGHVDHGKTTLTAALTYVAAAENPNVEVKDYGDIDKAPEERARGITINTAHVEYETAKRHYSHVDCPGHADYIKNMITGAAQMDGAILVVSAADGPMPQTREHILLARQVGVPYIVVFMNKVDMVDDPELLDLVEMEVRDLLNQYEFPGDEVPVIRGSALLALEEMHKNPKTKRGENEWVDKIWELLDAIDEYIPTPVRDVDKPFLMPVEDVFTITGRGTVATGRIERGKVKVGDEVEIVGLAPETRKTVVTGVEMHRKTLQEGIAGDNVGLLLRGVSREEVERGQVLAKPGSITPHTKFEASVYILKKEEGGRHTGFFTGYRPQFYFRTTDVTGVVRLPQGVEMVMPGDNVTFTVELIKPVALEEGLRFAIREGGRTVGAGVVTKILE
```

Note the provision of residue and chain information in the title line, and the specification of chemically modified residues using X and then the PDB three letter code in brackets. This type of FASTA file may be generated using the `pdb2fasta.py` script provided in the Rosetta `tools/rna_tools/pdb_util` directory.

The flags file might contain some optional arguments:

```
-edensity:map_reso 1.95   # the resolution of the electron density map
-score:weights stepwise/rna/rna_res_level_energy7beta.wts   # 'beta' scorefunction that serves as a starting point for the code
-set_weights elec_dens_fast 30.0 cart_bonded 50.0 linear_chainbreak 10.0 chainbreak 10.0 fa_rep 1.5 fa_intra_rep 0.5 rna_torsion 10 suiteness_bonus 5 rna_sugar_close 10   # modifications to the scoring function to make it more appropriate for electron density scoring
-rmsd_screen 3.0   # during rebuilds, only consider conformations within 3.0 Å of the starting conformation
-ignore_zero_occupancy false   # do not remove from the input model residues with zero occupancy in the PDB file
-missing_density_to_jump   # situational -- if there are gaps in the numbering, ensure they are connected by "jumps" in the Rosetta internal coordinate representation
-allow_virtual_side_chains false   # do not virtualize protein side chains during RNA resampling
-pack_protein_side_chains false   # do not pack protein side chains during RNA resamping
```

Expected Outputs
================

At the end you will get a output pdb file in standard pdb format. The output file is in the standard PDB format; you may want to add back in any metals, ligands, or water molecules that Rosetta could not model. (Rosetta uses an implicit solvent model and will not consider input waters.) You can then further refine the output model directly using PHENIX or other refinement packages without any post-processing.

New things since last release
=============================

* All the application used here (*erraser\_minimizer* , *swa\_rna\_analytical\_closure* and *swa\_rna\_main*) are new as of Rosetta 3.4. A new electron density scoring method `       elec_dens_atomwise      ` is used in ERRASER. ERRASER also uses an updated rna torsional potential based on RNA09 dataset. 
* Recent updates/fixes to the ERRASER code base have been made to address possible bug-related inaccuracies. For best results, all ERRASER users should download/install a weekly build of Rosetta 2015.35 (released Sept. 24, 2015) or later.


##See Also

* [[RNA applications]]: The RNA applications home page
* [[Utilities Applications]]: List of utilities applications
* [[Tools]]: Python-based tools for use in Rosetta
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Application Documentation]]: Home page for application documentation
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [RiboKit](http://ribokit.github.io/): RNA modeling & analysis packages maintained by the Das Lab
