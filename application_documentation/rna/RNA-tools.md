RNA tools
===========================================

Application purpose
===========================================

A collection of tools for PDB editing, cluster submission, 'silent-file' processing, and setting up rna_denovo and ERRASER jobs. 

Under active development by the Das laboratory (Stanford). 

Code
====

This documentation describes how to set up code in:

`tools/rna_tools/bin`

Setup
======
Include the following lines in your `.bashrc` (may be `.bash_profile` on some systems):

```
export ROSETTA='/home/yourhomedirectory/src/rosetta/'
export PATH=$ROSETTA/tools/rna_tools/bin/:$PATH
source $ROSETTA/tools/rna_tools/INSTALL
```

Instead of `/home/yourhomedirectory/`, use your actual path to Rosetta.

Then open a new terminal or type `source ~/.bashrc` to activate these paths & tools.

Some useful tools
==================
Following are example command lines for several of these Python-based tools:

PDB utilities
-------------
To change the residue numbers and chains in a file:

`renumber_pdb_in_place.py mymodel.pdb A:1-4 B:5-9`

or

`renumber_pdb_in_place.py mymodel.pdb 1-4 5-9`

To generate a fasta file with the sequences from a PDB:

`pdb2fasta.py mymodel.pdb  [ > mymodel.fasta ]`

To pull out a particular chain from a PDB file:

`extract_chain.py mymodel.pdb A `

To slice out particular residues from a PDB file:

`pdbslice.py mymodel.pdb -subset 1-5 9-12  mysubset_ `

The last argument is a prefix for the sliced PDB file.

To excise particular residues from a PDB file:

`pdbslice.py mymodel.pdb -excise 6-8  excised_ `

Again, the last argument is a prefix for the sliced PDB file.


Silent file utilities
----------------------
'Silent files' use Rosetta's compressed file format that concatenates the scores for each model as well as the model coordinates (sometimes in a UU-encoded compressed format that looks like gobbledygook).

To quickly get the number that goes with each score column (useful before making scatterplots in `gnuplot`), 

`fields.py mysilentfile.out`

To find the lowest energy 20 models within the silent file and run Rosetta's `extract_pdbs` executable to extract them:

`extract_lowscore_decoys.py mysilentfile.out 20`

To create a new silent file with just the lowest energy 20 models:

`extract_lowscore_decoys_outfile.py mysilentfile.out -out 20`

To concatenate several outfiles, renaming model tags to be unique:

`cat_outfiles.py mysilentfile1.out mysilentfile2.out [ ... ]`


RNA modeling utilities
----------------------

To generate a near-ideal A-form RNA helix that has good Rosetta energy (requires that `rna_helix` Rosetta executable is compiled): 

`rna_helix.py -seq aacg cguu -o myhelix.pdb [ -resnum 5-8 20-23 ]`

To strip out residues and HETATMs that are not recognizable as RNA from a PDB file:

`make_rna_rosetta_ready.py rawmodel.pdb`

*Legacy* [_Following functionalities are directly available in `rna_denovo` application now]: To prepare files for an RNA denovo (fragment assembly of RNA with full atom refinement, FARFAR) job:

`rna_denovo_setup.py -fasta mysequence.fasta -secstruct_file mysecstruct.txt`

See also: [[rna_denovo_setup|rna-denovo-setup]].


Cluster setup
-------------
These are largely geared towards clusters that the Das lab uses (stampede and other XSEDE resources; the BioX<sup>3</sup> computer at Stanford), but are meant to be easily generalized to new ones.

To create submission files for a set of Rosetta command lines in a `README` file:

`rosetta_submit.py README OUTDIR 40 [number of hours]`

The directory `OUTDIR` will contain directories `0/`, `1/`, to `39/` for 40 jobs. Your command-line should have a flag like `-out:file:silent mymodels.out`, which will be elaborated into flags like `-out:file:silent OUTDIR/0/mymodels.out` in the 40 jobs, so that theire outfiles will go into separate subdirectories and prevent file i/o conflicts.  

Submission scripts for Condor, LSF, PBS, and SLURM (stampede) will show up in the directory along with (hopefully) a suggestion for how to run them on your cluster. Default number of hours is 16, but can be changed above. **If you set up on a new cluster, please update rosetta_submit.py so that others can take advantage of your work.**

While running or after running, bring together models from the different outfiles into a single silent file by:

`easy_cat.py OUTDIR`



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