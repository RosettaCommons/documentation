#FARFAR2: Homology modeling and ab initio prediction of whole RNA 3D structures

#Application purpose
To produce <i>de novo</i> models of RNA structures up to around 250nt, or homology models of RNA structures where up to about 80 nt are not in known templates or A-form helices, through a parameter-optimized version of Fragment Assembly of RNA with Full Atom Refinement (FARFAR), which we're calling FARFAR2.

Note that most of the functionality of FARFAR2 is now available on a [ROSIE FARFAR server](http://rosie.rosettacommons.org/farfar2), if you want to do some easy tests.

#Code and Demo

The central code for the *rna\_denovo* application is in `       src/protocols/rna/denovo/RNA_DeNovoProtocol.cc      ` .

For a 'minimal' demo example of the RNA fragment assembly and full-atom minimization protocol and input files, see

`       demos/public/FARFAR2      `

#References
Watkins, A. M.; Das, R. “FARFAR2: Improved de novo Rosetta prediction of complex global RNA folds.” bioRxiv, 2019. [Link.](https://doi.org/10.1101/764449)

#Algorithm

Algorithmic description of FARFAR (i.e., Fragment Assembly of RNA with Full Atom Refinement) as a whole can be found [[here|rna-denovo]]. There are several distinctions that inaugurate FARFAR2 as a method appropriate for large RNA structure prediction.

-   In the original FARFAR method, helix flexibility with realistic kinematics could not be accounted for in a single clean pipeline. For single-step methods, users had to choose between pre-calculated fixed helical chunks (such that all the "strain" that might result would be expressed as chainbreaks at helix termini) and sets of `AtomPairConstraints` termed "base pair constraints" (such that all the "strain" would be found in poorly formed helices). If users were content to run a multi-step method (most weren't), they could pre-generate ensembles of helix structures for each position, and FARFAR would draw samples from those ensembles. This method offered marginal improvements at a severe complexity penalty. FARFAR2 instead implements "base pair step" sampling, which permits the substitution of quartets of helical residues, i.e., two consecutive base pairs, with new ideal samples. Thus, helix flexibility is sampled in-place, and any resulting strain is distributed among chainbreaks between all helical residues, more easily optimized away.

-   The original FARFAR method used an old scoring function developed for the original FARFAR (2010) work, which included multiple terms with derivative discontinuities under some circumstances like `ch_bond`. Since then, we have wanted to take advantage of all the scorefunction optimization for [[stepwise Monte Carlo|stepwise]], which is now default.

-   The original FARFAR method used a fragment library from 2009; we have updated it to 2018 and added flags for excluding fragments from any supplied `-native` structure to simulate benchmark-like conditions.

#Limitations

-   Sufficiently large RNAs are still hard to sample completely. Obviously, use templates if they are available, even for small portions of your target! Experimental data can help (see [[earlier work with the previous code|rna-assembly]]), as can [[strategies for building up models gradually|rna-denovo-setup], or solving small motifs first with [[stepwise]].

-   As with most other modes in Rosetta, the final ensemble of models is not guaranteed to be a Boltzmann ensemble. There is some progress happening in that direction for RNA with the [[recces]] application.

#Modes


-   By default, the code runs Monte Carlo fragment assembly, optimized in a knowledge-based low-resolution potential.

-   It is strongly suggested that you run with "-minimize\_rna", which permits the refinement in the high-resolution Rosetta potential, and results in models with few steric clashes and 'cleaner' hydrogen bonds.


#Input Files


##Required file

FARNA (rna_denovo) can accept sequence and secondary structure from command line, and does not require any files. However, using file input can help with organizing runs.

##Optional additional files:

-   The [[fasta file]]: it is a sequence file for your RNA. Its header lines can specify chains and numbering for the output structures, too.

-   The [[secondary structure file|rna-secondary-structure-file]]: holds the secondary structure for the RNA in dot-parens notation, if known.

-   Native pdb file, if all-heavy-atom rmsd's are desired. Must be in Rosetta's [PDB format for RNA](#File-Format).

##How to include these files.

A sample command line is the following:

```
rna_denovo.<exe> -sequence "ucaggu aagcag" -secstruct "(....( )....)" -nstruct 2 -out:file:silent test.out -minimize_rna 
```

or if you want to supply the sequence & secondary structure in files:

```
rna_denovo.<exe> -fasta chunk002_1lnt_.fasta -secstruct_file chunk002_1lnt_.secstruct -nstruct 2 -out:file:silent test.out -minimize_rna 
```

The code takes about 1 minute to generate two models.

The fasta file has the RNA name on the first line (after \>), and the sequence on the second line. Valid letters are a,c,g, and u. Example fasta and secstruct files are available in `       demos/public/rna_denovo      ` .

#Options
## Commonly used options
```
-in:fasta                                        Fasta-formatted sequence file. [FileVector]
-sequence                                        Sequence on command line (put in quotes; fasta input is preferred)
-secstruct_file                                  RNA sec struct to model in dot-parens notation
-secstruct                                       RNA sec struct on command line (put in quotes;  
                                                  secstruct_file input is preferred)
-out:file:silent                                 Name of output file [scores and torsions, compressed format]. default="default.out" [String]
-in:native                                       Native PDB filename. [File].
-out:nstruct                                     Number of models to make. default: 1. [Integer]
-minimize_rna                                    High resolution optimize RNA after fragment assembly.[Boolean]
-vary_geometry                                   Vary bond lengths and angles (with harmonic constraints near Rosetta ideal) for backbone and sugar degrees of freedom [Boolean]
```
## Useful options
```
-cycles                                          Number of Monte Carlo cycles.[default 10000]. [Integer]
-bps_moves                                       Base pair step moves. For adjacent base pairs within stems or that are
                                                 obligate pairs, draw sequence-matched fragments that encompass both
                                                 pairs. Adjacent means that base pairs have contiguous residues on one 
                                                 strand, and at most 3 intervening residues on the other.   
-output_lores_silent_file                        If high resolution minimizing, output intermediate low resolution models. [Boolean]
-dump                                            Generate pdb output. [Boolean]
-vall_torsions                                   Source of RNA fragments. [String]
-jump_library_file                               Source of base-pair rigid body transformations if base pairs are specified. [String]
-obligate_pair                                   Residue pairs that must form a base pair (possibly non canonical)
-secstruct_general                               Specification of -obligate_pair in dot-parens format
-obligate_pair_explicit                          Residue pairs that must form a base pair, with  specification of base 
                                                   edges (W/H/S/X) and orientation (A/P/X for antiparallel/
                                                   parallel/unknown; C/T/X allowed too for cis/trans)

-cst_file                                        Specify constraints (typically atom pairs) in Rosetta-style constraint file. [String]
-output_lores_silent_file                        if doing full-atom minimize, also save models after fragment assembly but before refinement (file will be called *.LORES.out) [Boolean]
-dump                                            output pdbs that occur during the run, even if using silent file output.
```
## Advanced options
```
Advanced 
-s                                               Input PDBs to be used as fixed 'chunks' in fragment assembly
-in:file:silent                                  List of input files (in 'silent' format) that specify potential template structures or 'chunks'
-input_res                                       Positions at which 'chunks' are applied. If there is more than one chunk file, specify indices for
                                                   the first file and then the second file, etc.
                                                 (Used to be called -chunk_res.)
-cutpoint_closed                                 Positions at which to force transient chainbreaks (may be needed
                                                  if you get fold-tree errors)
-cutpoint_open                                   Positions at which strands end (better to specify separate strands
                                                  in FASTA file, or with spaces between strings in sequence)
-data_file                                       RDAT or legacy-format file with RNA chemical mapping data
```

## Typically unused options (for completeness)
```
-filter_lores_base_pairs                         Filter for models that satisfy structure parameters. [Boolean] True by default.
-params_file                                     RNA params file name.[String]. For Example: -params_file chunk002_1lnt_.prm
                                                  Deprecated by -working_res option above.
-in:database                                     Path to rosetta databases. Default is based on location of rosetta executables. [PathVector]
-output_res_num                                  Numbering (and chain) of residues in output PDB or silent file. 
                                                  Better to specify in headers in .fasta file.
-staged_constraints                              Apply constraints in stages depending on sequence separation
-close_loops                                     Attempt closure across chainbreaks by cyclic coordinate descent after fragment moves [Boolean] Defaults to true.
```
#Tips


##File Format 
<a name="File-Format" />

Note that in older versions of Rosetta, the PDBs may have residue types marked as rA, rC, rG, and rU and unusual atom names. Versions of Rosetta released after 3.5 have residue and atom names matching BMRB/NDB standard nomenclature. If you have a "standard" PDB file, there is a python script available to convert it to current Rosetta format:

```
tools/rna_tools/bin/make_rna_rosetta_ready.py <pdb file>
```

##Can I specify non-Watson-Crick pairs? 
<a name="Can-I-specify-non-Watson-Crick-pairs?" />

You can also specify base pairs that must be forced, even at the expense of creating temporary chainbreaks, in the params file, with a flag like

```
-obligate_pair_explicit 2 11 W W A
```

This also allows the specification of non-Watson-Crick base pairs. In the line above, you can change the W's to H (hoogsteen edge) or S (sugar edge); and the A to P (antiparallel to parallel). The base edges are essentially the same as those defined in the classification by Leontis & Westhof. The latter (A/P) are determined by the relative orientation of base normals. [The cis/trans classification of Leontis & Westhof would be an alternate to the A/P, but we found A/P more convenient to compute and to visually assess. You can supply C/T for cis/trans, and it will be converted based on a lookup table.] The base pairs are drawn from a library of base pairs extracted from the crystallographic model of the large ribosomal subunit 1JJ2.

When specifying pairs, if there are not sufficient strand breaks to allow all the pairs to form, the code will attempt to choose a (non-stem) RNA suite to put in a cutpoint, which can be closed during fragment assembly with the -close\_loops option. If you want to pre-specify where this cutpoint will be chosen, add a flag like

```
-cutpoint_closed 6
```

##Can I use fragments that take advantage of our rich database of base pairings? 

Yes, by using the flags `-bps_moves`, you can ask the application to try to  draw from a database of "base pair steps". There are two kinds of those steps. 

First, for stems (specified by secondary structure file), adjacent base pairs form base pair steps, involving four nucleotides (i,i+1,j,j+1) where (i,j+1) and (i+1,j) are paired. There is a set of such steps in Rosetta's database, drawn from the ribosome. The RNA's fold tree will be set up with appropriate jump connections and cutpoints so that those base step conformations can be substituted in during fragment assembly.

Second, if you have specified obligate pairs -- but with unknown pairing edges and orientations ('X' in the params file) -- special fragments will be set up for such pairs that involve nucleotides that are adjacent in sequence. For example, if your params file contains a flag like:
```
-secstruct_general .((....)..).
```
or 
```
-obligate_pair 2 11  3 8 
```
using the flag `-bps_moves` will trigger moves that substitute sequence-matched fragments for the nucleotides at (2,3,8,11). This happens if on at least one strand, the base pair step involves residues that are immediately contiguous (2 and 3 in this example). On the other strand, the base pair step must involve residues that are contiguous are have no more than 3 intervening 'bulge' residues (8 and 11 in this example). Note that these base pair steps will generally include noncanonical pairs.  There's a demo of this functionality applied to model the sarcin/ricin loop in `demos/public/RNA_Denovo_with_base_pair_steps/`

Note: For noncanonical pairs, we don't allow specification of edges and orientations at the moment -- the database gets pretty sparse with that level of specification. Also note: If there is a base pair step that includes a pair both inside a Watson/Crick stem and a more general 'obligate pair', the stem pairing may actually come out as non-Watson-Crick, which often happens anyway for base pairs at the edge of stems.

##See Also

* [RiboKit](https://ribokit.github.io/workflows/3D_modeling/): Workflows for experimentally-guided RNA 3D modeling.
* [[RNA applications]]: The RNA applications home page
* [[Structure Prediction Applications]]: List of structure prediction applications
* [[Application Documentation]]: Home page for application documentation
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [RiboKit](http://ribokit.github.io/): RNA modeling & analysis packages maintained by the Das Lab