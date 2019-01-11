#How to prepare structures for use in Rosetta

*This page describes the standard procedure for preparing protein structures for Rosetta. To prepare ligands for use with Rosetta, see the [[preparing ligands]] page and [tutorial](https://www.rosettacommons.org/demos/latest/tutorials/prepare_ligand/prepare_ligand_tutorial). To prepare non-peptide polymers, see the [[preparing PDB files for non-peptide polymers]] page.  For PDB files containing both proteins and RNA, see the [[RNA-protein changes]] page.

You can find the introductory tutorial [here](https://www.rosettacommons.org/demos/latest/tutorials/input_and_output/input_and_output#controlling-input_preparing-a-structure-by-refinement). For details, continue reading.

[[_TOC_]]

# Application Purpose

Structures derived straight from the PDB are almost never perfectly compatible with Rosetta—it is common for them to have clashes (atom overlaps), amino acid rotamers with terrible Rosetta energy, or other errors. 
It is often beneficial to prepare the structures before doing real work on them to get these errors out of the way beforehand. This provides several benefits:

-   In design, Rosetta often places a certain amino acid solely because the original has a bad clash or rotamer energy, preparing structures first will allow Rosetta to keep the wild-type amino acid and minimize the number of changes made based on incorrect scoring of the native.
-   Less time is spent in each trajectory independently re-relaxing the same errors in the input.
-   The results have less noise caused by errors being handled in different ways in different trajectories.
-   Scores are lower overall—you should never have positive score12 (or talaris) scores for a well folded protein.

# References

Nivón LG, Moretti R, Baker D (2013) A Pareto-Optimal Refinement Method for Protein Design Scaffolds. PLoS ONE 8(4): e59004. [Paper](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0059004)

# How Do I Prepare Structures?

Preparing structures is inextricably linked to what you want to do with them. 
In other words, your main protocol dictates your preparation protocol. 
Remember that all you're really doing here is relaxing into Rosetta's energy function—you're not necessarily making it objectively more correct (although clashes are generally wrong), you're really just making Rosetta like it better. 
What follows is a protocol that has been benchmarked for enzyme design and should work for any design situation, and then a series of suggestions from Rosetta developers for other situations.

# Cleaning PDBs for Rosetta

Parsing a PDB structure downloaded from the [[PDB|http://www.rcsb.org/pdb/home/home.do]] often results in an error.
This is mostly due to the PDB containing extraneous information (such as waters which are not modeled by Rosetta).
Occasionally, this is due to Rosetta not being able to parse a particular chemical entity.

The simplest way to clean a PDB file is by running the following command-line expression:

```
grep "^ATOM" SOME.pdb > SOME.clean.pdb
```

**Warning:** this is rather barbaric and will get rid of PDB information which could be valuable.

There is also a script, `tools/protein_tools/scripts/clean_pdb.py`, for cleaning the PDB which will remove most lines that cannot be parsed by Rosetta.
As of June 9th, 2015, the script leaves only lines starting with 'ATOM' or 'TER' and removes 'HETATM' records unless the residue is a selenomethionine.
It also removes residues with 0 occupancy.
See the script header for more information.
To run the script:

```
python clean_pdb.py <pdb> <chain id>
```

## Clean PDBs with Ligand

There are cases where your PDB may contain a HETATM ligand, for obvious reasons you may want to relax the PDB with the ligand.
We often clean structures to replace non-canonical amino acids with their closest counterparts using `clean_pdb_keep_ligand.py`:
```
python clean_pdb_keep_ligand.py your_structure_original.pdb -ignorechain
```

These protocols are designed for a single-chain PDB. 
For multiple chains we recommend that you split the PDB into one for each chain and run the protocol separately on each. Alternatively, you can try using the `-ignorechain` option of the script, which will keep all chains.

While the previous script (clean_pdb.py) discarded most to all HETATM records, this script keeps HETATMs which are not non-canonical ligands.

# Relax With All-Heavy-Atom Constraints: Introduction

(See also the [[relax documentation|relax]] .)

We looked for a way to simultaneously minimize Rosetta energy and keep all heavy atoms in a crystal structure as close as possible to their starting positions. 
As many posts below—or hard-won experience—will show, running relax on a structure will often move the backbone a few Angstroms. 
The best way we have found to perform the simultaneous optimization is to run relax with constraints always turned on (typically constraints ramp down in the late cycles of a relax run) and to constrain not just backbone but also side-chain atoms (which can be done with both flags or a [[constraint file|constraint-file]], see [[preparing-structures#generating-constraints-file-for-your-pdb]]).
This protocol has been tested on a benchmark set of 51 proteins and found to increase sequence recovery in enzyme design by 5% as compared with design in raw PDB structures. 
It accomplishes this with only .077 Angstrom RMSD over the set of proteins (C-alpha RMSD) from raw PDB to relaxed-with-csts PDB. 
A more complete description of the data leading to this protocol is below.

# Relax With All-Heavy-Atom Constraints: Protocol

The required files are in: `Rosetta/main/source/src/apps/public/relax_w_allatom_cst`. 

There is also a demo with a constraint file rather than flags at: `Rosetta/demos/public/prepare_pdb_for_rosetta_with_relax`.

### Short Protocol (recommended, no constraint file)

Relax with all-heavy-atom constraints is built into the relax application itself. 
If this is a new structure you may want to first clean it up using the above script. Relax proceeds as follows:

```
relax.linuxgccrelease  -database Rosetta/main/database [-extra_res_fa your_ligand.params] -relax:constrain_relax_to_start_coords -relax:coord_constrain_sidechains -relax:ramp_constraints false -s your_structure.pdb
```

The flags file can contain whatever packing and scorefunction flags you wish to use. We recommend at least:

```
-ex1
-ex2
-use_input_sc
-flip_HNQ
-no_optH false
```

The strength and type of constraints uses can be varied with the `       -relax:coord_cst_stdev      ` and `       -relax:coord_cst_width      ` options. 
By default relax uses a harmonic constraint with the strength adjusted by `coord_cst_stdev` (smaller=tighter). 
If `coord_cst_width` is specified, a flat-bottomed, linear-walled constraint is used, with the size of the flat-bottomed well controlled by `coord_cst_width` (smaller=tighter), and the slope of the walls by `coord_cst_stdev` (smaller=tighter). 
More on constraint functions can be found [[here|constraint-file#function-types]].

### Longer Protocol (not recommended, using a constraint file)

In general the short protocol is preferred for most applications, since this version is more complicated and the two give nearly identical results. 
In this protocol an separate script first generates side-chain atom constraints from an input PDB, then the relax protocol is run with this pre-generated constrain file. 
The shorter protocol does this all in one step, and **this version is largely deprecated**. 
Certain users might prefer this protocol because it allows you to see a list of all constraints, and perhaps to modify constraints using other scripts/data, prior to relax.

1. Generate side-chain coordinate constraints on your PDB using `sidechain_cst_3.py`:

    ```
    python sidechain_cst_3.py your_structure.pdb 0.1 0.5
    ``` 
    [output: your\_structure\_sc.cst]

2. Run relax using these constraints and with a custom relax script to force constraints to stay on during the entire run. 
Run time is approximately 30 minutes for a 340 residue protein.

    ```
    relax.linuxgccrelease  -database Rosetta/main/database -relax:script Rosetta/main/source/src/apps/public/relax_w_allatom_cst/always_constrained_relax_script -constrain_relax_to_start_coords -constraints:cst_fa_file your_structure_sc.cst -s your_structure.pdb [-extra_res_fa your_ligand.params]
    ```

The bracketed `extra_res_fa` only applies if there are any ligand(s) in the structure. 
The example flags file listed below was used in testing:

```
-ex1
-ex2
-use_input_sc
-correct
-no_his_his_pairE
-score::hbond_params correct_params
-lj_hbond_hdis 1.75
-lj_hbond_OH_donor_dis 2.6
-linmem_ig 10
-nblist_autoupdate true
-no_optH false
-flip_HNQ
-chemical:exclude_patches LowerDNA UpperDNA Cterm_amidation SpecialRotamer
VirtualBB ShoveBB VirtualDNAPhosphate VirtualNTerm CTermConnect sc_orbitals
pro_hydroxylated_case1 pro_hydroxylated_case2 ser_phosphorylated
thr_phosphorylated tyr_phosphorylated tyr_sulfated lys_dimethylated
lys_monomethylated lys_trimethylated lys_acetylated glu_carboxylated
cys_acetylated tyr_diiodinated N_acetylated C_methylamidated
MethylatedProteinCterm
```

Note: Including extra rotamers is important if your goal is to keep all side-chain atoms tightly constrained; if that is not important for your applications, exclude the ex1 and ex2 for speed.

# Relax With All-Heavy-Atom Constraints: Data

To test protocols for relaxation of input PDBs we used the 51 scaffold test set for enzdes. 
We run design over the input structures and calculate the percent of residues which come back with the native identity—sequence recovery, only over the designed residues. 
This is of course an imperfect metric (the original sequence might not be fully optimal), but it allows us to ask how many residues Rosetta will correctly choose, assuming that the input structure is already at a minimum in sequence space for the ligand in question. 
It had already been found that relax alone (with no constraints) will distort most structures, and that those structures will give a much higher sequence recovery in design, but this is a result of the distortion to the input structure.

We decided to test a few protocols to find the one that would best minimize RMSD from the original PDB while maximizing sequence recovery. 
All calculations are averages over 50 runs of the 51 scaffold set. 
All RMSDs are to native C-alpha. 
It is also possible to read in electron density for a PDB and use that as a constraint during relax (described [[here|density-map-scoring]]), but electron density is not uniformly available, and we were looking for a protocol that would work in every case even if the electron density was lacking. 
We chose the first protocol as the best because it minimized RMSD (and side-chain motions) while maximizing sequence recovery.  See [[Nivon et al|preparing-structures#References]] for more information.

Running relax with side-chain coordinate constraints and backbone coordinate constraints: (ex flags and use native; ex flags on in enzdes)

-   0.447 sequence recovery (0.077 RMSD) [-557 totalscore]

Running relax with sidechain-sidechain distance constraints at 3.5 distance cutoff. 
Note that this gets similar RMSD minimization but doesn't maximize sequence recovery or minimize score as well as coordinate constraints. 
We tested this protocol with a variety of sidechain-sidechain distance constraint cutoff values and found it to slightly but systematically underperform coordinate constraints:

-   0.436 sequence recovery (0.0706 RMSD) (-534 totalscore)

Running relax with backbone constraints only: 
(Note that this does worse in terms of RMSD and that many side-chains are a few angstroms off)

-   0.488 sequences recovery (0.098 RMSD) (-633 totalscore)

No relax benchmark and Rosetta scoring of native input structures:

-   0.40 (0 RMSD by definition) (-194.7 totalscore)

At this point, the astute reader might ask, what score terms became 438 Rosetta Energy Units (REU) better? 
We ranked the difference in scores over all structures, comparing the all-atom coordinate constraint protocol and the non-relaxed input structure.
The biggest difference is fa\_dun (-192.4), followed by fa\_rep (-108.1), pro\_close (-26.4), hbond\_sc (-10.8) and omega (-8.5). 
Many input rotamers are close to but not in a "good" Dunbrack rotamer, and the backbone has to be slightly tweaked in order for that residue to get a good dunbrack score. 
Also, many atoms are slightly too close, and they give the fa\_rep contribution.

# Developer Discussion: Original Question from Ramesh Jha

Is there a consensus protocol to create the starting PDBs to be used in mini (Rosetta)? 
It is not unknown that the PDBs right from the Protein Data Bank are composed of artifacts and defects that can give an exceptional jump in energy if happened to be altered during a design protocol. 
In order to minimize this problem, there are a few things which can be tried and that I am aware of:

1. Repack (with or without `-use_input_sc`)
2. Repack w/ `sc_min`
3. Relax (fast relax w/ or w/o `use_input_sc`)
4. Idealize

Having tried all of them, I thought the option 3, was the best one, where I used fast relax while using `-use_input_sc` flag. 
But recently I observed that though 'relax' is able to substantially decrease the energy of starting PDBs, also result in subtle movements in the backbones and a PDB which could accommodate a ligand could not anymore after being relaxed.

## James's Reply

Try adding the `-constrain_relax_to_start_coords` option to your protocol \#3.

## Ben's Reply

I've been using a protocol that does sc & bb minimization, full packing with `-use_input_sc`, then minimization of bb, rb, and sc. 
It's located in: `rosetta/rosetta\_source/src/apps/pilot/stranges/InterfaceStructMaker.cc`. 
The idea with this is that it keeps things from moving too far from the starting structure. 
There's no backbone sampling so I typically find RMSD to the crystal structure to be \< 1.0. 
Relax actually will do explicit bb sampling thus gives a lower energy structure than my protocol but can also introduce the changes that you observed. 
I'm pasting my typical options file below:

```
-database Rosetta/main/database
-nstruct 20
-ndruns 10
-no_his_his_pairE
-run::min_type dfpmin_armijo_nonmonotone
-ignore_unrecognized_res
-use_input_sc
-ex1
-ex2
-no_optH false
-overwrite
-allow_rbmin true
-min_all_jumps true
-mute protocols.moves.RigidBodyMover protocols.moves.RigidBodyMover core.scoring.etable core.pack.task protocols.docking.DockingInitialPerturbation protocols.TrialMover core.io.database
```

## Sagar's Reply

I just use repack with `-sc_min`, and include the ligand in the process.

## Rocco's Reply

There is a fixed-backbone minimization program that's part of the ligand docking application, ligand\_rpkmin (See section "Preparing the protein receptor for docking" of [[the ligand docking documentation|ligand dock]].

It won't relieve any backbone strain, though, so you may still have issues if the downstream protocol allows for backbone movement.

## Steven C.'s Reply

In general, the Meiler lab does the following:

1. Obtain the protein using a script (see attached python scripts. (scripts were written by I believe James Thompson from the Baker lab and edited by me to work with the Meiler lab configuration) The script cleans, renumbers, and removes multiple conformations of residues from the protein.
2. `relax.linuxgccrelease -ex1 -ex2 -ex1aro -relax:sequence`

This will alleviate clashes in the protein and give a good starting structure for any of the Rosetta applications...unless the protein blows up for some reason.

With an addendum from James Thompson:

Thanks Steven! That's a very reasonable way to gently structures from the PDB, although there are a lot of different ways that you might try this.

Here are two more things that come to mind:

-   If you notice that your protein is moving too much, try adding the `-constrain_relax_to_start_coords` option. This will use coordinate constraints to make your protein stay closer to your input model.
-   Also, Mike Tyka wrote that script for cleaning up PDBs. One of the most useful parts of that script is that it matches non-canonical amino acids (such as selenomethionines) with the appropriate canonical amino acid.

With a second addendum from Andrew Leaver-Fay:

I thought I might point out two things:

1. ex1aro doesn't do anything extra if you already have ex1 on your command line. You can however set the sampling level for ex1aro to be higher than for ex1; e.g. `-ex1 -ex1aro:level 4`. This is stated very explicitly in the option documentation, yet still surprises a lot of people. In Rosetta++, `-ex1aro` behaved as if it were `-ex1aro:level 4`.
2. Mike has observed that extra rotamers will not yield better energy structures out of relax; they will however slow it down.

# Limitations

This is not "normal" relax, that is to say, it will not find the global energy minimum for your structure, it will only find a good energy that is consistent with the input atom positions.

# Post Processing

What post processing steps are typical? 
Are score vs RMSD plots useful? 
Are structures clustered (if so, give a command line)? 
Is it obvious when either the application has succeeded or if it has failed (e.g. if the protocol makes predictions like "This is the docked conformation of proteins A and B"). 
In the case of designs, how should designs be selected?

## See Also

* [[Making Rosetta robust against malformed PDBs|robust]]
* [Controlling Input and Output Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/input_and_output/input_and_output#controlling-input_preparing-a-structure-by-refinement)
* [[Preparing ligands]]: Preparing ligands for use in Rosetta
* [Preparing non-protein residues Tutorial](https://www.rosettacommons.org/demos/wiki/tutorials/prepare_ligand/prepare_ligand_tutorial)
* [[Preparing PDB files for non-peptide polymers]]
* [[Preparing PDB files containing protein and RNA|RNA-protein-changes]]
* [[Running Rosetta with options]]: Instructions for running Rosetta applications on the command line
* [[File types list]]: File types used in Rosetta