#Comparative modeling of protein structures

This document describes comparative modeling using the minirosetta applocation.
For a newer approach for performing comparative modeling in Rosetta, see [[RosettaCM]]


Metadata
========

Author: James Thompson

This document was last updated on November 21st, 2010 by James Thompson (tex@uw.edu) . The PI is David Baker (dabaker@uw.edu) . The Rosetta comparative modeling protocol was developed primarily by the following members of the Rosetta Commons:

-   Carol Rohl
-   Dylan Chivian
-   Bin Qian
-   Srivatsan Raman
-   Michael Tyka
-   Frank DiMaio
-   James Thompson

Code and Demo
=============

The code for running comparative modeling is in `       rosetta/main/source/src/protocols/comparative_modeling      ` and `       rosetta/main/source/src/protocols/loops      ` . See the `       rosetta/tests/integration/tests/threading      ` directory for an example command-line and input files.

An introductory tutorial on comparative modeling can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/rosetta_cm/rosetta_cm_tutorial).

References
==========

-   Srivatsan Raman, Robert Vernon, James Thompson, Michael Tyka, Ruslan Sadreyev,Jimin Pei, David Kim, Elizabeth Kellogg, Frank DiMaio, Oliver Lange, Lisa Kinch, Will Sheffler, Bong-Hyun Kim, Rhiju Das, Nick V. Grishin, and David Baker. (2009) Structure prediction for CASP8 with all-atom refinement using Rosetta. *Proteins* 77 Suppl 9:89-99.
-   Dylan Chivian and David Baker. (2006). Homology modeling using parametric alignment ensemble generation with consensus and energy-based model selection. *Nucleic Acids Research* 34(17)e112.

Application purpose
===========================================

This application was developed to build structural models of proteins using one or more known structures as templates for modeling.

Algorithm
=========

The Rosetta comparative modeling approach is divided into four steps. The first step is generation of alignments to one or more template structures. We currently use external programs for this purpose, including BLAST, PSI-BLAST, HMMER and HHSearch. For more information on the alignment problem as it relates to comparative modeling problem, see Chivian and Baker (2006). The second step is generation of an incomplete model based on the template structure by copying coordinates over the aligned regions and rebuilding the missing parts using loop modeling. For more information, see the documentation for the loop modeling application. The third step is a full-atom refinement of the protein model using the Rosetta full-atom energy function. The final step is a selection of the models using clustering. File formats and command-line flags are detailed below in the [Options](#Options) section below).

The current standard protocol is to generate 10,000 separate models using the protocol detailed in this document, select the lowest 10% of models by energy, and then choose clusters using the "Cluster" application."

Input Files
===========

-   Fasta file. Contains the amino acid protein sequence in fasta format.

-   Fragment files. Generate structural fragment libraries using either the publicly available webserver ( [http://robetta.bakerlab.org/fragmentsubmit.jsp](http://robetta.bakerlab.org/fragmentsubmit.jsp) ) or a local installation of the rosetta\_fragments package.

-   Native structure (optional). The native PDB structure may be used for benchmarking. When used, the RMSD to native is calculated for each model and provided as an extra column in the score line.

-   Psipred secondary structure prediction psipred\_ss2 file (optional). The Psipred secondary structure prediction file can be used to pick chainbreak points for loop-modeling, and is optional.

-   A template pdb file for threading

-   A sequence alignment file

Options
=======

Comparative modeling can be run using the minirosetta application with the following flags (to list all relevant commands, run with -help option):

```
./bin/minirosetta.linuxgccrelease
-run:protocol threading

-in:file:fasta t288_.fasta                                                    Query FASTA sequence
-in:file:fullatom
-out:file:fullatom

-loops:frag_files aat288_09_05.200_v1_3.gz aat288_03_05.200_v1_3.gz none     Fragment files
-loops:frag_sizes 9 3 1                                                      Number of residues in each fragment file

-in:file:native native.pdb                                                  Native structure (optional)
-in:file:psipred_ss2 t288_.psipred_ss2                                        PSIPRED-SS2 File (optional)
-in:file:fullatom

-idealize_after_loop_close                                                    Idealize structure after closing loops

-loops:extended
-loops:build_initial
-loops:remodel quick_ccd                                                     Method for rebuilding loops
-loops:relax fastrelax                                                       Protocol for full-atom refinement
-relax:fastrelax_repeats 8                                                    Number of full-atom refinement cycles

-in:file:alignment t288_.result.filt.valid                                    Alignment file
-cm:aln_format grishin                                                        Alignment file format
#-cm:aln_format general                                                       if general format is used
-in:file:template_pdb 1be9A.pdb                                               List of template PDBs
-database path/to/rosetta/main/database                                       Path to rosetta database
-nstruct 1                                                                    Number of output structures
-out:file:silent t288_.silent.out                                             Use silent file output, use filename after this flag, default=default.out
(or -out:pdb)                                                                 Use PDB file output, default=false
-out:path /my/path                                                            Path where PDB output files will be written to, default '.'
```

The "grishin" file format for sequence alignments is listed below:

```
## t288_ 1be9A_4
# hhsearch_3 33
scores_from_program: 0.000000 0.998400
2 VPGKVTLQKDAQNLIGISIGGGAQYCPCLYIVQVFDNTPAALDGTVAAGDEITGVNGRSIKGKTKVEVAKMIQEVKGEVTIHYNKLQ
9 EPRRIVIHRGS-TGLGFNIIGGED-GEGIFISFILAGGPADLSGELRKGDQILSVNGVDLRNASHEQAAIALKNAGQTVTIIAQYKP
--
```

The first two lines represent the identifier of the query and template sequences, and 1be9A.pdb must provided on the command-line with the -in:file:template_pdb option (listed above). The string "1be9A\_4" should be a unique identifier for the sequence alignment. Alignment identifiers are stored in silent-files, and each structure in a silent-file should store which alignment was used as a template for model building.

If you provide alignment file in general format use the flag -cm:aln_format general
The general format looks like:

score 123.456
t288_		1 VIAFRCPRSFMDQPLAEHFSPFRVQHMDLSNS------VIEVSTL
1be9A 	1 ILSLRRSLSYVIQGMANIESLNLSGCYNLTDNGLGHAFVQEIGSL

1be9A.pdb must provided on the command-line

See the [[AbinitioRelax extract options|abinitio-relax#Options]] and [[AbinitioRelax cluster options|abinitio-relax#Options]] for information on how to extract PDBs and cluster silent-files from comparative modeling.

##See Also

* [Comparative Modeling Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/rosetta_cm/rosetta_cm_tutorial)
* [[Minirosetta]]: More information on the MiniRosetta app
* [[Structure prediction applications]]: A list of other applications to be used for structure prediction
  * [[NonlocalAbinitio]]: Application for predicting protein structure given some prior structural information
  * [[Abinitio Relax]]: Application for predicting protein structure based solely on its amino acid sequence
    * [[Abinitio]]: Further details on this application
  * [[Membrane abinitio]]: Ab initio for membrane proteins.  
  * [[Metalloprotein ab initio|metalloprotein-abrelax]]: Ab inito modeling of metalloproteins.  
  - [[Backrub]]: Create backbone ensembles using small, local backbone changes.  
  - [[Comparative modeling|minirosetta-comparative-modeling]]: Build structural models of proteins using one or more known structures as templates for modeling.  
  - [[Floppy tail]]: Predict structures of long, flexible N-terminal or C-terminal regions.
  - [[Fold-and-dock]]: Predict 3-dimensional structures of symmetric homooligomers.  
  - [[Molecular replacement protocols|mr-protocols]]: Use Rosetta to build models for use in X-ray crystallography molecular replacement.  
    * [[Prepare template for MR]]: Setup script for molecular replacement protocols.  
  - [[Relax]]: "Locally" optimize structures, including assigning sidechain positions.
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
