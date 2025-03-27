#Ligand\_dock application


##NOTE: Use of this app is no longer recommended for ligand docking. Use [[RosettaScripts]] instead. See [[HighResDockerMover]] for example.

Metadata
========

This document was written 4 Feb 2008 by Ian W. Davis.

Lasted Edited 10/6/14 by Jared Adolf-Bryfogle.

An introductory tutorial on ligand docking can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/ligand_docking/ligand_docking_tutorial).


Example runs
============

See `       rosetta/main/tests/integration/tests/ligand_dock_7cpa      ` for an example docking run and input files. Note that the flags there do NOT reflect current best practice, and the flags in this document are a better guide.

Literature references
=====================

-   Jens Meiler and David Baker (2006). "ROSETTALIGAND: Protein-Small Molecule Docking with Full Side-Chain Flexibility" Proteins 65, 538-548.
-   Ian W. Davis and David Baker (2008). "ROSETTALIGAND docking with full ligand and receptor flexibility" J Mol Biol 385, 381-392.
-   Ian W. Davis et al. (2009). "Blind docking of pharmaceutically relevant compounds using RosettaLigand" Protein Sci 18, 1998-2002.

Known bugs and limitations
==========================

I'm sure there are many. In particular, it's currently designed for a single ligand as a single residue, which must be the last in the file. Gordon Lemmon, Kristian Kaufmann, and Andrew Leaver-Fay are in the process of implementing multi-residue ligands (June 2008).  

Note that much of the continued development of RosettaLigand is within the RosettaScripts interface. See Combs, DeLuca, et al (2013). "Small molecule ligand docking into comparative models with Rosetta." Nature Protocols.    


**Tips for running RosettaLigand via [[RS | Movers-RosettaScripts#ligand-centric-movers]]**

_ScoreFunction_


Be sure to use -restore_pre_talaris_defaults option and use the scorefunction from the paper.  You can also experiment with orbitals_talaris1013 (with the option -add_orbitals and without -restore_pre_talaris_defaults), however it has not been optimized for this purpose yet.

If you use other scorefunctions, make sure to add these terms:

   coordinate_constraint 1.0
   atom_pair_constraint 1.0
   angle_constraint 1.0
   dihedral_constraint 1.0
   chainbreak 1.0

_Conformer Generation_


Generating conformers for your ligand is very important.  However, there are a plethora of available tools to do so.  Take a look at Ebejer et al, "Freely Available Conformer Generation Methods: How Good Are They?" J Chem Info and Modeling.  Also, MOE and openeye omega seem to work well and are popular in the literature if you have a license.

How to get these into Rosetta:

Currently, you regenerate ligand conformations using your choice of conformer generation tools (i use MOE, some people like openeye omega, there are many options), and then output those conformations as a pdb file, with the conformations separated by  TER cards.  You then add a PDB_ROTAMERS line to your params file, like this:

PDB_ROTAMERS path.pdb

where path.pdb is the pdb file containing your rotamers. this path is relative to the params file (I usually keep them in the same directory).  These conformers will be imported as a single residue rotamer library, and can be sampled by the packer, or manually (as occurs in low resolution docking)


Application purpose
===========================================

This application takes a receptor structure (typically a protein) and a small molecule, and tries to find a conformation and relative orientation of each that minimizes the Rosetta score function. Typical applications include structure-based drug design and perhaps as a step in enzyme design. Virtual screening may be possible, but will require enormous computational resources. Both virtual screening and affinity prediction require robust ways of comparing scores between different ligands, which are different sizes (more atoms = more possible favorable interactions) and have different numbers of rotatable bonds (affects entropy of binding) – I have not addressed this problem yet. Only protein receptor and drug-like ligands have been tested with this code. Ligands should generally have less than 40 non-hydrogen atoms and less than 10 rotatable bonds. Larger and more flexible ligands can be used, but the results generally degrade the larger the ligand gets.

Algorithm
=========

The algorithm is similar to that in Meiler & Baker 2006, except with many fewer cycles of refinement; the full details of the flexible backbone docking algorithm appear in Davis & Baker 2008. The starting position for the ligand can be specified explicitly (`-docking:ligand:start_from X Y Z`) or implicitly (starting coordinates in the PDB file). It is then typically perturbed by a relatively large, user specified amount (see sample flags, below) so as to explore the entire binding pocket. Then the Monte Carlo minimization begins: For 6 cycles, the ligand is slightly perturbed, sidechains are repacked, and if the energy hasn't increased too much all degrees of freedom are minimized. Cycles 1 and 4 get a full repack; the others just get rotamer trials. If ligand rotamers are supplied, then the ligand can be packed also. Each cycle is followed by a Monte Carlo accept/reject. At the end, the lowest energy pose is recovered and further minimized. If the protein backbone is to be minimized, it moves only during this final minimization. Interpretation of the output scores is described below.

Overview
========

Here is a "checklist" for setting up a ligand docking experiment. Details for all the steps are given below.

1.  Reformat starting structures
    1.  Protein receptor in PDB format with no waters or cofactors; each metal ion should have a unique chain ID.
    2.  Cofactors, if any, should be in .sdf or .mol2 format, with coordinates taken from the original PDB file.
    3.  Ligands to be docked should be in .sdf or .mol2 format, one ligand per file. If you're trying to reproduce a known binding mode, those ligand coordinates should be used.

2.  Prepare ligands and cofactors
    1.  Generate conformers if desired. All conformers should be in the same .sdf / .mol2; one file per compound. Tautomers / protomers count as different compounds.
    2.  Assign partial charges if desired. Only charges from the first entry in the file are used. Charges can only be read from .mol2 files.
    3.  Convert the .sdf / .mol2 into a .params file and one or more .pdb files. The .params describes atom types, charges, and rotatable bonds; the .pdb files contain ligand coordinates.
    4.  Make a ligand conformer library if desired. Concatenate the desired coordinates in PDB format and add a "PDB\_ROTAMERS ..." line to the .params file.

3.  Prepare the receptors
    1.  Repack the entire receptor in the presence of cofactors but the absence of ligands.
    2.  Choose the lowest-energy result to use as the repacked structure.
    3.  I repack by running [[relax]] with the sequence option

4.  Generate input files for Rosetta
    1.  Ligand .params files
    2.  Ligand conformer libraries (typically \*\_confs.pdb)
    3.  Input PDB: repacked protein + generated ligand conformation
    4.  Native PDB: experimental protein and ligand coordinates (optional, for RMSD calculations)
    5.  Unbound PDB: experimental protein without ligand (optional)
    6.  Rosetta flags file (typically FLAGS.txt)

5.  Run docking trajectories
6.  Analyze results
    1.  Concatenate silent.out files to get one per ligand/receptor pairing.
    2.  Extract score and RMSD information; make scatterplots.
    3.  Cluster ligand conformations.
    4.  Estimate docking confidence.

Automatic RosettaLigand Setup (ARLS)
====================================

-Deprecated- (still works, just generally not recommended any longer)
Most of the steps to set up a RosettaLigand docking run have been automated by the `       arls.py      ` script (`rosetta/main/source/src/apps/public/ligand_docking/`, run with –help for brief instructions). For those who prefer a manual approach, the individual steps are detailed in the following sections.

The inputs to ARLS are *apo* protein structures (.pdb) and cofactor and ligand files (.mol, .sdf, or .mol2). I typically use PyMOL to edit the proteins, [OpenBabel](http://openbabel.org/) to convert PDB ligands to SDF, and [Avogadro](https://avogadro.cc/) to fix any mistakes in the SDF (all are free). You also need a file with one line per docking case, listing the protein name, cofactor name(s) if any, and ligand name (without file extensions). This file shows docking several compounds into an apo structure of farnesyl transferase, in most cases including a farnesyl pyrophosphate as a cofactor:

```
1fpp 1mzc_FPP 1o5m
1fpp 1mzc_FPP 1s63
1fpp          1s64
1fpp 1mzc_FPP 1sa4
```

In the same directory are found 1fpp.pdb, 1mzc\_FPP.sdf, 1o5m.sdf, 1s63.sdf, etc.

Running ARLS with this list produces a collection of scripts that automate the stages of the docking process:

-   1\_setup.sh – Creates parameter files and rotamer libraries for cofactors and ligands. Uses OpenEye's Omega to generate conformers, if available.
-   2\_prepack\_minimize.sh – Prepares protein(s) for docking by repacking sidechains and minimizing. Optional but recommended. Will use multiple processors if arls.py is given -jN.
-   3\_tarball\_pre.sh – Gathers up the generated input files for transfer to a compute cluster like SYD.
-   4\_dock\_condor.sh – Creates output directory structure and CONDOR.dock submit script for the docking jobs. Other queuing systems are not currently supported, but you can at least use this as a guide.
-   5\_concat.sh – Gathers the output from individual processes into one file per protein-ligand pair, and creates a tarball to copy back for analysis.
-   6\_analyze\_results.sh – Automates some common analysis steps. Extracts spreadsheet-style tables of scores, uses R to plot binding energy vs. RMSD, guesses whether each docking was successful, and extracts PDBs of the best-scoring poses.

Also, the Rosetta flags controlling the prepacking and docking steps are written to some \*.flags files. The meaning of most options is commented in these files.

ARLS uses a variety of other binaries and scripts to do its work. It should usually be able to find the Rosetta source, but may need help to find the /path/to/rosetta/main/database and the OpenEye tools; see –mini, –database, and –openeye. If you do not have the OpenEye tools, you should –skip-omega and –skip-charges. In that case, you'll need to make sure that the small molecule input files already contain all the conformers you want to consider. You should also provide partial charges (use .mol2 format), or you'll get the default Rosetta (protein) charges.

Preparing the small-molecule ligand for docking
===============================================

Rosetta defines ligand topology, rotatable bonds, atom types, partial charges, etc in a .params file; the starting coordinates are stored in PDB format. A script called `       molfile_to_params.py      ` has been supplied in `       rosetta/main/source/scripts/python/public/      ` to help in producing these files from a typical small molecule format (.mol, .sdf, or .mol2).

In most cases, one starts from a random 3D conformation or a 2D or 1D chemical formula (e.g. SMILES) and needs to generate a library of plausible, low-energy conformations. I use OpenEye's Omega, like this:

```
~/openeye/bin/omega2 -in 1t3r.sdf -out 1t3r_confs.mol2 -commentEnergy -includeInput
```

Then I use OpenEye's AM1-BCC implementation to calculate partial charges. (You must have a valid license and OpenEye libraries and Python bindings installed to use assign\_charges.py; feel free to substitute some other program you like.) Only the partial charges on the first conformer in the .mol2 file are used by subsequent steps, so there's no point in calculating charges for all conformers. If all charges are left as zero / unassigned (i.e. you skip this step), default partial charges for Rosetta's atom types will be used.

```
~/rosetta/main/source/src/apps/public/ligand_docking/assign_charges.py < 1t3r_confs.mol2 > 1t3r_charges.mol2
```

Special records can be added to the file to specify the atom tree root or split the molecule into multiple residues, but these are not generally used right now. Otherwise, `       molfile_to_params.py      ` is controlled by command line parameters.

```
~/rosetta/main/source/scripts/python/public/molfile_to_params.py -n DAR -k 1t3r.kin -p 1t3r 1t3r_charges.mol2
```

`       -n      ` gives the three-letter code that will be used for the PDB residue name, `       -p      ` controls naming of the output files, and `       -k      ` produces a kinemage illustration of the ligand (optional, but useful for debugging; see [http://kinemage.biochem.duke.edu](http://kinemage.biochem.duke.edu) to download KiNG for viewing).

If you want to use all the conformers in Rosetta's packer during the docking run, you must cat them all into one file and add a PDB\_ROTAMERS line to the bottom of the .params file. Otherwise, just the conformation in the input PDB will be used.

Because I use `       -includeInput      ` with Omega, I need to omit the crystallographic ligand coordinates (`       1t3r_0001.pdb      `) from the ligand conformer library. For docking benchmarks, those coordinates can be used for the reference ("native") structure, so Rosetta will calculate meaningful RMSD values.

```
mkdir conf1
mv 1t3r_0001.pdb conf1/
cat 1t3r_????.pdb > 1t3r_confs.pdb
echo "PDB_ROTAMERS 1t3r_confs.pdb" >> 1t3r.params
```

When running Rosetta, the 1t3r.params and 1t3r\_confs.pdb files must be in the same directory as each other.

Preparing the protein receptor for docking <a name="ligand_rpkmin" />
==========================================

Only sidechains near the initial ligand position are repacked during docking, to save time. This means *all* sidechains should be repacked before docking, so that any pre-existing clashes (according to Rosetta's energy function) can be resolved. Otherwise, a ligand placed near the clashing residues will allow them to repack and thus gain a large energy bonus that does not accurately reflect its binding affinity in that position. A program `       ligand_rpkmin      ` is provided for this purpose; one should use the same `       -ex#      ` flags as will be used during docking.

```
~/rosetta/main/source/bin/ligand_rpkmin.macosgccrelease -database ~/rosetta/main/database/ -ex1 -ex2 -ex1aro -extrachi_cutoff 1 \
  -no_optH false -flip_HNQ -docking:ligand:old_estat -docking:ligand:soft_rep -nstruct 10 -s 1t3r.pdb
```

The input PDB should consist of the protein chain(s), each with its own chain ID, followed by any metal ions (PDB residue names must be right aligned, e.g. " ZN" or " MG") or cofactors, also with their own unique chain IDs. Parameter files for cofactors should be prepared just as for ligands, and the generated PDB coordinates should be used here (the \*\_0001.pdb conformer will be the input coordinates if you used -includeInput with Omega). Cofactor conformer libraries are not necessary and are usually not desireable (no PDB\_ROTAMERS line in the .params file). The ligand(s) to be docked should be omitted to avoid biasing the docking toward the known structure. Some sidechains may repack into the binding pocket; the docking algorithm will move them out of the way as needed.

Because the repacking is stochastic, I typically generate 10 structures per receptor and choose the one lowest in energy:

```
$ awk '/^pose / {print FILENAME, $NF}' 1t3r*.pdb | sort -nk2
    1t3r_0010.pdb -623.12
    1t3r_0008.pdb -622.922
    1t3r_0007.pdb -622.865
    1t3r_0003.pdb -622.818
    1t3r_0001.pdb -622.749
    1t3r_0002.pdb -622.446
    1t3r_0009.pdb -622.234
    1t3r_0005.pdb -621.866
    1t3r_0004.pdb -621.73
    1t3r_0006.pdb -619.961
$ cp 1t3r_0010.pdb 1t3r_input.pdb
```

Once we start introducing backbone flexibility, the backbone will have to be preminimized as well, possibly with a relax protocol. (Because the backbone flexibility we have introduced so far involves few residues, and those are restrained, we do not currently seem to need pre-minimization of the protein backbone.)

The input PDB for docking should consist of the protein chain(s) followed by the ligand residue in a separate chain; this generally just means appending one of the ligand PDBs from the previous step onto the cleaned up protein PDB. Any other information should be removed from the PDB before starting, although Rosetta scoring information and the like are generally ignored without problems. Cofactor ligands may be left in place as long as the ligand to be docked comes last in the file; they will not move. Waters and ions may also be left in the PDB (after the protein, before the ligand) if appropriate .params files are provided for them. "TER" cards are currently ignored by the PDB reader, so each cofactor, ion, water molecule, etc. needs to have its own unique chain identifier.

Generally, I use the first Omega-generated conformer plus the repacked protein coordinates as the input to docking. Using the crystalized ligand coordinates may lead to artificially good results in docking benchmarks.

```
cat params/1t3r_0002.pdb >> 1t3r_input.pdb
```

For a cross-docking experiment, you need 3 input structures:

-   "input": repacked protein plus a random ligand conformer (e.g. lig\_0002.pdb)
-   "native": co-crystal protein coordinates with co-crystal ligand (lig\_0001.pdb)
-   "unbound": co-crystal protein with no ligand (confusing name from protein-protein docking)

The input is essential, and is provided via the `       -s      ` switch. The native is optional; it allows Rosetta to calculate meaningful RMSD values and is provided via `       -native      ` . If no native is provided, the input will be used to calculate RMSDs. The unbound is also optional; it tells Rosetta what sidechain conformations were observed in the crystal structure (these will be favored during repacking). The unbound is specified with `       -unboundrot      ` .

For cross docking, it is important not to include the co-crystal ligand coordinates in either the input or the unbound PDB file: If you do, it will bias the docking by giving Rosetta the bioactive ligand conformation as one of its rotamers. It's safe to include the co-crystal ligand coordinates in the "native" PDB file; these are only used for calculating RMS and will not influence the course of the docking.

Usage for a Production Run
==================

A total of 2000 - 10000 docking trajectories are often necessary to be reasonably sure of correctly docking the ligand, depending on how well the location of the binding site is known. (Docking against the whole protein surface could require many times more trajectories.)

I typically run on the Baker lab's large "syd" cluster, which uses Condor for scheduling, and I typically run 5 - 10 processes per ligand with `       -nstruct      ` of 500 - 1000. Each process should have its own output directory to avoid overwhelming the NFS file servers. For example, an entry from my Condor submit script:

```
Executable = /work/davis/ligand_dock.linuxiccrelease
Universe = vanilla
Initialdir = /work/davis/projects/jnk_sampl

Arguments = @FLAGS.txt -in:file:s input/jnk_pp_1_001.pdb -out:path:pdb work/jnk_pp_1_001/$(Process) -run:seed_offset $(Process) -out:suffix _$(Process)
Queue 10
```

The FLAGS.txt file (any name will do) contains most of the flags that specify behavior. In this case, I'm defining the binding site I want to sample with 6 spheres, each with a 5A radius. A total of 5000 trajectories will run (10 x 500). Especially for large ligands, I typically run 5000 trajectories per one 5A sphere (or equivalent volume: two 4A spheres, etc). The spheres describe where the NBR\_ATOM of the ligand may be placed; other parts of the ligand will likely stick out of these spheres. By default, the NBR\_ATOM is chosen to be near the ligand's center, so you can think of it as the ligand's center of mass.

```
-in
 -path
  ## On a large cluster, the database should be on a local scratch disk
  ## to avoid over-taxing NFS.
  -database /scratch/USERS/davis/rosetta/main/database
  ## "Fallback" database locations can also be specified,
  ## in case the primary database is missing on some nodes:
  -database /work/davis/rosetta/main/database
 -file
  ## You must supply .params files for any residue types (ligands)
  ## that are not present in the standard Rosetta database.
  -extra_res_fa input/jnk.pp.1_001.params input/jnk.pp.1_002.params  # ...
  ## If you weren't supplying the input file(s) on the command line,
  ## this is where you would put them:
  #-s input/jnk_pp_1_001.pdb  # ...
  ## To get meaningful RMS values in the output, either the input PDB must have
  ## the ligand in the correct place, or you must supply another file that does:
  #-native jnk_1_native.pdb
-out
 ## These channels generate a LOT of output,
 ## especially with -improve_orientation.
 -mute protocols.geometry.RB_geometry core.scoring.dunbrack.SingleLigandRotamerLibrary core.scoring.rms_util
 ## Number of trajectories to run (per input structure given with -s)
 -nstruct 500
 ## With multiple processes, ensures a unique name for every output structure.
 ## Each process should get a different string here, so you can't really
 ## put it in the FLAGS.txt file, it has to go in the Condor script:
 #-suffix 3
 -file
  ## I prefer output structures with Rosetta numbering, from 1 to N residues.
  ## To keep the original PDB numbering, omit this flag:
  -renumber_pdb
 -path
  ## Where to write the silent.out file.  Specified in my Condor script.
  #-pdb work/jnk_pp_1_001/3
-run
 ## Recording the SVN revision of the code in your output files
 ## makes it easier to figure out what you did later.
 -version
 ## MT is now the default random number generator, actually.
 #-rng mt19937
 ## Do nothing for 0 - N seconds on startup.  If many processes are started
 ## at once, this helps avoid too much I/O as they all load the database.
 -random_delay 240
-packing
 ## If your PDB file does not have hydrogens in the right places, use this:
 #-no_optH false
 ## Includes the input sidechain conformations as rotamers when repacking,
 ## but they can be "lost" if any other rotamer is chosen at that position.
 #-use_input_sc
 ## Instead, use -unboundrot to permanently add the rotamers from one or more
 ## PDB files.  Their rotamer ("Dunbrack") energies are also adjusted to be
 ## equal to the best rotamer at that position, thereby favoring the native.
 ## Since most sidechains do not change position much upon ligand binding,
 ## including this knowledge generally improves docking results:
 -unboundrot jnk_apo_native.pdb
 ## Controls the number of (protein) rotamers used.
 -ex1
 -ex1aro
 -ex2
 ## Ensures that extra rotamers are used for surface residues too.
 -extrachi_cutoff 1
-docking
 ## Flags to control the initial perturbation of the ligand,
 ## and thus how much of the binding pocket to explore.
 ##
 ## Random perturbation of up to N Angstroms in X, Y, and Z,
 ## drawn from a uniform distribution.
 ## This gives a cube, but points outside the sphere of radius N are discarded,
 ## resulting in uniform positional sampling within the sphere.
 -uniform_trans 5   # angstroms
 ## Randomize the starting orientation and conformer (respectively) of the
 ## ligand.  Unnecessary if using -improve_orientation.
 #-randomize2
 #-random_conformer
 ## An alternative to -uniform_trans and -randomize2.
 ## Random perturbations in X, Y, and Z and the 3 Euler angles,
 ## drawn from a Gaussian distribution.
 ## I *believe* that the three Gaussians in X, Y, and Z actually give a
 ## spherically isotropic distribution of positions, but large angles
 ## clearly give unreasonable results (use -randomize2 instead).
 ## This can be used for positional perturbation only (instead of
 ## -uniform_trans) by setting the angle component to zero.
 #-dock_pert 30 5  # rot degrees, trans angstroms
 -ligand
  ## Instead of choosing an orientation and conformer at random,  try all
  ## available conformers in N random orientations, and try to maximize
  ## shape complementarity to the protein (keeping in mind that sidechains
  ## may move later, etc etc.  See the paper or code for details.)
  ## We find this *significantly* improves search, and costs just a few seconds.
  -improve_orientation 1000
  ## Let ligand rotatable bonds minimize, with harmonic restraints
  ## where one standard deviation is 10 degrees:
  -minimize_ligand
  -harmonic_torsions 10
  ## In the final minimization, let the backbone minimize with harmonic
  ## restraints on the Calphas (stddev = 0.3 A).
  ## Only stretches of residues near the ligand are minimized,
  ## typically 20 - 40 in total.  (40 - 80 residues are repacked.)
  -minimize_backbone
  -harmonic_Calphas 0.3
  ## Use soft-repulsive scoring during search (but not final minimization).
  ## This slightly improves search.  Hard-rep is used for final scoring,
  ## however, because it gives better discrimination.
  -soft_rep
  ## Like Rosetta++, only evaluate the Coloumb term between protein and ligand.
  -old_estat
  ## The 6-cycle protocol with repacks in cycles 1 and 4.
  -protocol abbrev2
  ## In each trajectory, one of the following points will be chosen at random
  ## as the starting point for the ligand centroid (followed by other
  ## perturbations like -uniform_trans, etc).
  -start_from 20.0 28.4 26.0
  -start_from 23.3 18.9 26.0
  -start_from 28.7 14.0 19.6
  -start_from 16.9 16.0 32.7
  -start_from 21.3 10.8 31.1
  -start_from 25.6  4.4 32.5
  ## By supplying multiple .params files that have the same 3-letter residue
  ## name, the same heavy atoms, but different proton configurations, you can
  ## sample different protomers / tautomers within the packing steps.
  ## In many cases this gives a negligible increase in run time (nice).
  ## However, I'm unaware of any cases (so far) where it actually helped
  ## to improve docking results, so use at your own risk.
  #-mutate_same_name3
```

Analysis of outputs
===================

Each process will produce a "silent file" with that contains the endpoint of every trajectory. These silent files can be safely concatenated to give a single output file per ligand. Make sure to use `       -out:prefix      ` and/or `       -out:suffix      ` with each process to ensure unique tag names, however.

Currently they're stored in my own "atomtree diff" format which is very efficient: one reference structure plus \~10 kb per additional structure. This is important because each process can run one trajectory in 30 seconds, and dumping full PDBs would overwhelm the shared file system. After the initial reference structure in PDB format, docking entries look like this:

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

The label "7cpa\_0\_0\_0001" is a "tag", used for uniquely identifying each docking result – like a file name in a directory. My program `       extract_atomtree_diffs      ` can be used to convert entries from these files into regular PDBs. By default, all structures in the silent file are extracted, but you can extract only the best scoring ones (for example) by listing the tags on the command line with the `       -tags      ` flag.

The supplied script `       best_ifaceE.py      ` will read a silent file and print the tags of the best-scoring poses. In the Bash shell, you can use this output directly to get the 10 best poses:

```
~/rosetta/main/source/bin/extract_atomtree_diffs.macosgccrelease -database ~/rosetta/main/database -extra_res_fa input/1t3r.params \
  -s 1t3r_silent.out -tags $(~/rosetta/main/source/src/apps/public/ligand_docking/best_ifaceE.py -n 10 1t3r_silent.out)
```

Atomtree diff files are plain text, and final scores are recorded on the SCORES lines. These can be easily processed by scripts to select the best results. I often convert to a table of scores (CSV or equivalent) and do analysis in R; you could do the same in Excel, etc.

```
~/rosetta/main/source/src/apps/public/ligand_docking/get_scores.py < 1t3r_silent.out > 1t3r_scores.tab
```

Scores of interest include "total\_score", the overall Rosetta energy for the receptor-ligand complex; "interface\_delta", which estimates the binding energy as the difference between total\_score and the score of the separated components; and "ligand\_auto\_rms\_no\_super", the RMSD between the final ligand position and its position in the input (or `       -native      ` ) PDB file, accounting for any chemical symmetries (automorphisms). The individual components of total\_score are also present, as are the components of interface\_delta (prefixed by "if\_").

I've gotten good results with the following ranking scheme. I first discard any structures where the ligand is not touching the protein (ligand\_is\_touching = 0). Then I take the top 5% by total energy (total\_score). Then I rank the rest by the interaction energy between protein and ligand only (interface\_delta); this is the score difference between the components together and the components pulled apart by 500A. Among the lowest energy structures, this eliminates some uncorrelated noise from minor variation in the protein and focuses on protein-ligand interactions. This is the scoring scheme implemented by `       best_ifaceE.py      ` , which can be run directly on the silent file to discover the "best" docking results.

If the initial position of the ligand is meaningful (e.g. benchmarking to reproduce a known binding mode), the you can plot interface\_delta for these top-scoring structures against ligand\_auto\_rms\_no\_super and you should get a nice docking funnel. The ligand\_auto\_rms\_with\_super can be used to see how much ligand conformational variation you're getting in the output structures. (The difference is whether or not the ligands are superimposed; the "auto" is short for "automorphism", which means certain kinds of chemical symmetry are accounted for when calculating the RMS.)

Clustering ligand poses <a name="selectbestuniqueligandposes" />
=======================

By clustering ligand poses, and choosing the best model from each low energy cluster, one can curate a small set of possible binding modes for further investigation.

Although there is a clustering application within the Rosetta framework (the "cluster" application - see [[the documentation|cluster]] ), it is written to work primarily with protein structures, and by default works with C-alpha rmsd as the distance metric. Given that the Rosetta ligand\_dock application performs only limited backbone movement, and that most ligands do not have C-alpha atoms, the clusters thus obtained are unlikely to be relevant.

A better alternative is to use the ligand-docking specific "select\_best\_unique\_ligand\_poses" application. This is a greedy algorithm clustering approach, which first filters structures by ligand\_is\_touching/total\_score as in the [Analysis of outputs](#Analysis-of-outputs) section above. It then ranks structures by the interface\_delta metric, going down the list and outputting structures which are at least a given threshold of ligand-only rmsd away from any of the structures that have been output so far, up to a given maximum. It will also produce a file "cluster\_rms.tab" in the running directory giving the rmsd values between the output structures.

The select\_best\_unique\_ligand\_poses application uses the "jd2-style" options to control input and output. Note that the ligand\_is\_touching/total\_score/interface\_delta metrics are taken from the input files and not recomputed, so only atom\_tree\_diff and silent file inputs coming from the ligand\_dock application make sense as inputs.

```
General Options:
   -database                       Path to rosetta databases
     -extra_res_fa                   Location of param files for ligand and cofactors
   -in:file:atom_tree_diff         Input file in atom_tree_diff format
     -in:file:silent                 Input silent file (*1)
     -out:file:atom_tree_diff        Output file for atom_tree_diff format output (default)
     -out:pdb                        Output best unique ligand poses as PDBs instead
     -out:path:pdb                   Directory to place output PDBs in
   -out:file:silent                Output silent structures instead of atom_tree_diffs/PDBs (*2)
     -out:file:silent_struct_type    Type of silent file output ("binary" recommended)
Program-specific Options:
     -docking:ligand:max_poses       Number of structures to output (default 50)
   -docking:ligand:subset_to_keep  Fraction of top total_score structures to keep (default 0.05) (*3)
     -docking:ligand:min_rms         Ignore structure if rmsd to previously output structure is less than this (default 0.8)
```

* (\*1) For backwards compatability with previous versions of select\_best\_unique\_ligand\_poses, if the file passed to -in:file:silent looks like an atom\_tree\_diff, it will be treated as one. Explicitly set -in:file:silent_struct_type with the appropriate value to override this behavior. 
* (\*2) For backwards compatability, if -out:file:silent_struct_type is not set, the filename passed to -out:file:silent will be treated as if it were passed to -out:file:atom_tree_diff 
* (\*3) If -docking:ligand:subset\_to\_keep is greater than 1.0, it will be interpreted as the number of top total\_score to keep, rather than a fraction.

Estimating docking confidence (PRELIMINARY)
===========================================

A confidence index can be calculated as the correlation between energy score and the distance (RMSD) from the lowest energy pose. This method assumes that there is one low energy binding mode. Further Reading: [Maria I. Zavodszky, Andrew W. Stumpff-Kane, David J. Lee, and Michael Feig. **Scoring confidence index: statistical evaluation of ligand binding mode predictions** , *Journal of computer aided design* 1999, **23** (5):289-299](https://doi.org/10.1007/s10822-008-9258-8)


##See Also

* [Ligand Docking Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/ligand_docking/ligand_docking_tutorial)
* [[Docking Applications]]: Home page for docking applications
* [[Preparing ligands]]: Notes on preparing ligands for use in Rosetta
* [[Non-protein residues]]: Notes on using non-protein molecules with Rosetta
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[RosettaScripts]]: Homepage for the RosettaScripts interface to Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
