#Mg(2+) modeling
==================================

Application purpose
===========================================

This code allows build-up of three-dimensional de novo models of RNAs of sizes up to ~300 nts, given secondary structure and experimental constraints. It can be carried out reasonably automatically, but human curation of submodels along the build-up path may improve accuracy. A fully automated pipeline is in preparation (a previous iteration of this is described in [[rna assembly]] documentation).

Algorithm
=========

The current implementation of Mg(2+) docking is based on an enumerative grid search. Modeling of the hydration shell has been accelerated through heuristics for initial placement/removal of waters and orientation of water hydrogens.


Limitations
===========

-   These methods' predictive power have not been well tested. These classes should be easy to incorporate into structure prediction & design methods, such as the [[fragment assembly|rna-denovo-setup]] or [[stepwise]] frameworks. 

-    It seems likely that incorporation of solutions to the nonlinear Poisson-Boltzman equation, which models regions of high electrostatic potential due to long-range effects, would complement the current code, which (in classic Rosetta style)

Code and Demo
=============

The main code is available in the `mg_modeler` executable, with source code in `src/apps/public/magnesium/mg_modeler.cc`.

Test files and example command lines are available in integration tests:

```
       main/tests/integration/tests/mg_modeler      
       main/tests/integration/tests/mg_modeler_lores
```      


References
==========
This work is unpublished. Please contact rhiju [at] stanford.edu for information about citing or extending Rosetta Mg(2+) modeling.

Input Files
===========

Required file
-------------

You need two input files to run structure modeling of complex RNA folds:

-   The [[fasta file]]: it is a sequence file for your rna.
-   The [[secondary structure file]]: text file with secondary structure in dot-parentheses notation.

Optional additional files:
--------------------------
-   Any pdb files containing templates for threading.
-   Native pdb file, if all-heavy-atom rmsd's are desired. Must be in Rosetta's [PDB format for RNA](#File-Format).

Making models
===========
Following are examples for a sequence drawn from RNA puzzle 11, a long hairpin with several submotifs. The fasta file `RNAPZ11.fasta` looked like this:

```
> RNAPZ11 (7SK RNA 5' hairpin)
gggaucugucaccccauugaucgccuucgggcugaucuggcuggcuaggcggguccc
```

and the secondary structure file `RNAPZ11.secstruct` for the whole problem looked like this:

```
((((((((((.((((...(((((((....))).)))).))..))...))))))))))
gggaucugucaccccauugaucgccuucgggcugaucuggcuggcuaggcggguccc
```

There are four helices, H1, H2, H3, and H4.

Step 1. Make helices
---------------------------

Helices act as connectors between motifs. It can be useful to pre-build these and keep them fixed during each motif run, as grafting (Step 4 below) requires superimposition between shared pieces of separately built motifs.

A sample command line is the following:

```
rna_helix.py  -o H2.pdb -seq cc gg -resnum 14-15 39-40
```

This application output the helix with chains A and B, but removing the chains prevents some confusion with later steps, so you can run:

```
replace_chain_inplace.py  H2.pdb 
```

To setup the above python scripts, follow the directions for setting up [[RNA tools|rna-tools]].
Example files and output are in:

`       demos/public/rna_puzzle/step1_helix/      `

Step 2. Use threading to build sub-pieces
---------------------------

In the problem above, there is a piece which is a well-recognized motif, the UUCG apical loop.

Let's model it by threading from an exemplar
of the motif from the crystallographic database. There is one here:

Download 1f7y.pdb from `http://pdb.org/pdb/explore/explore.do?structureId=1f7y`.

Slice out the motif of interest:
```
pdbslice.py  1f7y.pdb  -subset B:31-38 uucg_
```

Thread it into our actual sequence:
```
rna_thread -s uucg_1f7y.pdb  -seq ccuucggg -o uucg_1f7y_thread.pdb
```

Let's get the numbering to match our actual test case:

```
renumber_pdb_in_place.py uucg_1f7y_thread.pdb 24-31
```

Example files and output are in:

`       demos/public/rna_puzzle/step2_thread/      `

Step 3. De novo model loops, junctions, & tertiary contacts of unknown structure by FARFAR
---------------------------
To build motifs or several motifs together, we will use de novo Rosetta modeling. In this example, we'll model the motifs between H2 and H4, using our starting H2 and H4 helices as fixed boundary conditions.  Note that a more advanced method, [[stepwise modeling|stepwise]] is also available for high resolution modeling (and is actually easier to run the fragment assembly), but remains mostly untested in the context of buildup of large RNA complex folds; for motifs that have any kind of homology to existing junctions/motifs, FARFAR should be better & faster.

Fragment assembly of RNA with full atom refinement (FARFAR) is not yet equipped to map numbers from our full modeling problem into subproblems. We have to create input files to `rna_denovo` for a little sub-problem and map all the residue numberings into the local problem. There is currently a wrapper script that sets up this job:

```
rna_denovo_setup.py -fasta RNAPZ11.fasta \
    -secstruct_file RNAPZ11_OPEN.secstruct \
   -working_res 14-25 30-40 \
   -s H2.pdb H4.pdb \
   -fixed_stems \
   -tag H2H3H4_run1b_openH3_SOLUTION1 \
   -native example1.pdb 
```

You don't need to supply a native if you don't have it -- just useful
to compute RMSDs as a reference.

Then try this:

```
 source README_FARFAR
```

Example output after a couple of structures is in `example_output/`, and in this case goes to `H2H3H4_run1b_openH3_SOLUTION1.out`.

For convergent results, you may have to do a full cluster run -- some tools are available for
 `condor`, `qsub`, `slurm` queueing systems as part of [[rna tools|rna-tools]].

Extract 10 lowest energy models:

extract_lowenergy_decoys.py H2H3H4_run1b_openH3_SOLUTION1.out 10

Inspect in Pymol. (For an automated workflow, you can also cluster these runs and just carry forward the top 5 clusters.)
Demo files are available in:
`       demos/public/rna_puzzle/step3_farfar/      `

Some useful options for `rna_denovo_setup.py`

```
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

Step 4. Build-up larger pieces by grafting or by more FARFAR <a name="rna-graft" />
---------------------------
Once you have several models of sub pieces, they can be combined in two ways.

One option is to run further FARFAR jobs (rerun Step 3), but supplying solutions to sub-pdbs via `-s <pdb1> <pdb2> ...` into larger modeling jobs. This is particularly powerful if a set of jobs can be set up in which each new job builds an additional peripheral element or junction into a well-converged model of a sub-set modeled in a previous job – a stepwise buildup, analogous to what is being explored in [[high-resolution stepwise modeling|stepwise]].

Alternatively, you can quickly graft two PDBs based on superimposition of shared residues, either using the `align` command in Pymol, or with the following Rosetta command lines:

```
rna_graft -s H2H3H4_run1b_openH3_SOLUTION1.pdb  uucg_1f7y_thread.pdb  H1H2_run2_SOLUTION1.pdb -o full_graft.pdb
```
Demo files are available in:
`       demos/public/rna_puzzle/step4_graft/      `



##See Also

* [[RNA Denovo]]: The main rna_denovo application page
* [[RNA applications]]: The RNA applications home page
* [[Structure Prediction Applications]]: List of structure prediction applications
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Application Documentation]]: Home page for application documentation
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files