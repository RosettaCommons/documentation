#Abinitio Relax

Metadata
========

Author: David E Kim
This document was last updated on October, 2014 by Jared Adolf-Bryfogle. The PI is David Baker (dabaker@uw.edu) . The AbinitioRelax application was developed by numerous Rosetta Commons members, primarily:

-   Kim Simons
-   Richard Bonneau
-   Kira Misura
-   Phil Bradley
-   Oliver Lange
-   Michael Tyka
-   Robert Vernon

An introductory tutorial _ab initio_ tutorial can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/denovo_structure_prediction/Denovo_structure_prediction).

Code and Demo
=============

The ab initio executable is in `       main/source/src/apps/public/AbinitioRelax.cc      ` . The source code for the ab initio protocol is in `       main/source/src/protocols/abinitio/AbrelaxApplication.cc      ` . See the `       demos/abinitio      ` directory for an example ab initio run which includes input files, expected output files, and an example run log. The example command exists in `       demos/abinitio/readme.txt      ` . Input files exist in `       demos/abinitio/input_files      ` . Expected output files exist in `       demos/abinitio/output_files      ` . An example run log exist in `       demos/abinitio/log      ` .

References
==========

-   Srivatsan Raman, Robert Vernon, James Thompson, Michael Tyka, Ruslan Sadreyev,Jimin Pei, David Kim, Elizabeth Kellogg, Frank DiMaio, Oliver Lange, Lisa Kinch, Will Sheffler, Bong-Hyun Kim, Rhiju Das, Nick V. Grishin, and David Baker. (2009) [Structure prediction for CASP8 with all-atom refinement using Rosetta.](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3688471/) *Proteins* 77 Suppl 9:89-99.
-   Bradley P, Misura KM, Baker D (2005). [Toward high-resolution de novo structure prediction for small proteins.](https://www.sciencemag.org/content/309/5742/1868.full) *Science* 309, 1868-71.
-   Bonneau R, Strauss CE, Rohl CA, Chivian D, Bradley P, Malmstrom L, Robertson T, Baker D. (2002) [De novo prediction of three-dimensional structures for major protein families.](http://www.sciencedirect.com/science/article/pii/S0022283602006988) *J Mol Biol* 322(1):65-78.
-   Bonneau R, Tsai J, Ruczinski I, Chivian D, Rohl C, Strauss CE, Baker D. (2001) [Rosetta in CASP4: progress in ab initio protein structure prediction.](http://onlinelibrary.wiley.com/doi/10.1002/prot.1170/full) *Proteins* Suppl 5:119-26.
-   Simons KT, Ruczinski I, Kooperberg C, Fox B, Bystroff C, Baker D. (1999) [Improved recognition of native-like protein structures using a combination of sequence-dependent and sequence-independent features of proteins.](http://onlinelibrary.wiley.com/doi/10.1002/(SICI)1097-0134(19990101)34:1%3C82::AID-PROT7%3E3.0.CO;2-A/full) *Proteins* 34(1) 82-95.
-   Simons KT, Kooperberg C, Huang E, Baker, D. (1997) [Assembly of protein tertiary structures from fragments with similar local sequences using simulate anealing and Bayesian scoring functions.](http://www.sciencedirect.com/science/article/pii/S0022283697909591) *J Mol Biol* 268:209-25.

Application purpose
===========================================

This application was developed to predict the 3-dimensional structure of a protein from its amino acid sequence.

Algorithm
=========

The AbinitioRelax application consists of two main steps. The first step is a coarse-grained fragment-based search through conformational space using a knowledge-based "centroid" score function that favors protein-like features (Abinitio). The second optional step is all-atom refinement using the Rosetta full-atom forcefield (Relax). The "Relax" step is considerably more compute-intensive and time-consuming than the first step. The example run described above in the [Code and Demo](#Code-and-Demo) section takes around 8 minutes to generate one model of a 117 residue protein on a modern computer. A single AbinitioRelax run can generate a user defined number of models via a command line option (see [Options](#Options) section below). For increased conformational sampling, this application is easily parallelized by executing numerous jobs each using a unique random number seed (see [Options](#Options) section below). This is typically done by submitting multiple jobs to a computer cluster or distributed grid. Since the full-atom energy function is very sensitive to imperfect atomic interactions and more noise will exist with insufficient sampling, convergence towards the native structure may require a significant amount of sampling. Additionally, to increase your chance of sampling the correct topology, a diverse set of homologous sequences, preferably with sequence changes that may have a greater impact on sampling like deletions and differences in conserved positions, may also be run since a homologue may converge towards the native structure with significantly less sampling (see Bradley *et al* reference).

Input Files
===========

-   Fasta file. Contains the amino acid protein sequence in fasta format. Example: `        rosetta_demos/abinitio/input_files/1elwA.fasta       ` .

-   Fragments files. Generate structural fragment libraries using either the publicly available webserver ( [http://robetta.bakerlab.org/fragmentsubmit.jsp](http://robetta.bakerlab.org/fragmentsubmit.jsp) ) or a local installation of the rosetta\_fragments package. Example: `        rosetta_demos/abinitio/input_files/aa1elwA03_05.200_v1_3       ` and `        rosetta_demos/abinitio/input_files/aa1elwA09_05.200_v1_3       ` .

-   Native structure (optional). The native PDB structure may be used for benchmarking. When used, the RMSD to native is calculated for each model and provided as an extra column in the score line. Example: `        rosetta_demos/abinitio/input_files/1elw.pdb       `

-   Psipred secondary structure prediction psipred\_ss2 file (optional). The Psipred secondary structure prediction file is necessary when the -use\_filters and -kill\_hairpins options are used (see below). Note: the fragment webserver runs Psipred and provides the psipred\_ss2 output file. Example: `        rosetta_demos/abinitio/input_files/1elwA.psipred_ss2. `
Please note that the file format for these options has changed between Rosetta3.4 and 3.5 (the demo is also out of date).  Please see  [this](https://www.rosettacommons.org/content/killhairpin-error) post for more information.

Options <a name="Options" />
=======

AbinitioRelax
-------------

You can run the AbinitioRelax application with the following flags (to list all relevant commands, run with -help option):

```
../../bin/AbinitioRelax.linuxgccrelease
-in:file:native ./input_files/1elw.pdb              Native structure (optional)
(or -in:file:fasta ./input_files/1elwA.fasta)       Protein sequence in fasta format (required if native structure is not provided)
-in:file:frag3 ./input_files/aa1elwA03_05.200_v1_3  3-residue fragments (fragments file)
-in:file:frag9 ./input_files/aa1elwA09_05.200_v1_3  9-residue fragments (fragments file)
-database path/to/rosetta/main/database             Path to rosetta database
-abinitio:relax                                     Do a relax after abinitio ("abrelax" protocol), default=false.

-nstruct 1                                          Number of output structures
-out:file:silent 1elwA_silent.out                   Use silent file output, use filename after this flag, default=default.out
(or -out:pdb)                                       Use PDB file output, default=false
-out:path /my/path                                  Path where PDB output files will be written to, default '.'
```

There are several optional settings which have been benchmarked and tested thoroughly for optimal performance (we recommend using these options):

```
-use_filters true                               Use radius of gyration (RG), contact-order, and sheet filters. This option conserves computing
                                                by not continuing with refinement if a filter fails. A caveat is that for some sequences, a large
                                                percentage of models may fail a filter. The filters are meant to identify models with non-protein
                                                like features. The names of models that fail filters start with F_.
-psipred_ss2 ./input_files/1elwA.psipred_ss2    psipred_ss2 secondary structure definition file (required for -use_filters)
-abinitio::increase_cycles 10                   Increase the number of cycles at each stage in ab initio by this factor.
-abinitio::rg_reweight 0.5                      Reweight contribution of radius of gyration to total score by this scale factor.
-abinitio::rsd_wt_helix 0.5                     Reweight env,pair,cb for helix residues by this factor.
-abinitio::rsd_wt_loop 0.5                      Reweight env,pair,cb for loop residues by this factor.
-relax::fast                                    Do a fastrelax which is significantly faster than the traditional relax protocol without a significant
                                                performance hit.
-kill_hairpins ./input_files/1elwA.psipred_ss2  Setup hairpin killing in score (kill hairpin file or psipred file). This option is useful for all-beta
                                                or alpha-beta proteins with predicted strands adjacent in sequence since hairpins are often sampled too
                                                frequently.  Note that the file format has changed from 3.4 to 3.5.  See Input Files section.
```

For running multiple jobs on a cluster the following options are useful:

```
-constant_seed                                  Use a constant seed (1111111 unless specified with -jran)
-jran 1234567                                   Specify seed. Should be unique among jobs (requires -constant_seed)

-seed_offset 10                                 This value will be added to the random number seed. Useful when using time as seed and submitting many
                                                jobs to a cluster.  If jobs are started in the same second they will still have different initial seeds
                                                when using a unique offset. If using Condor (http://www.cs.wisc.edu/condor), the Condor process id,
                                                $(Process), can be used for this. For example "-seed_offset $(Process)" can be used in the condor submit file.
```

The standard command line for optimal performance is shown below (nstruct should be set depending on how many models you want to generate):

```
../../bin/AbinitioRelax.linuxgccrelease \
        -database /path/to/rosetta/main/database \
        -in:file:fasta ./input_files/1elwA.fasta \
        -in:file:native ./input_files/1elw.pdb \
        -in:file:frag3 ./input_files/aa1elwA03_05.200_v1_3 \
        -in:file:frag9 ./input_files/aa1elwA09_05.200_v1_3 \
        -abinitio:relax \
        -relax:fast \
        -abinitio::increase_cycles 10 \
        -abinitio::rg_reweight 0.5 \
        -abinitio::rsd_wt_helix 0.5 \
        -abinitio::rsd_wt_loop 0.5 \
        -use_filters true \
        -psipred_ss2 ./input_files/1elwA.psipred_ss2 \
        -kill_hairpins ./input_files/1elwA.psipred_ss2 \
    -out:file:silent 1elwA_silent.out \
        -nstruct 10
```

Extracting PDB models from a silent output file using the score application
---------------------------------------------------------------------------

The resulting output using the command above is a silent output file (1elwA\_silent.out) which contains the PDB models and Rosetta score information in a compact format. To extract the PDB models into individual PDB files from the silent file you can use the [[score.linuxgccrelease|score-commands]] score application. Alternatively, you can use the -out:pdb option to output models in PDB format files.

Clustering using the cluster application
----------------------------------------

Models from a single silent output file can be clustered using the [[cluster.linuxgccrelease|cluster]] cluster application.

PDB files of the cluster members are extracted from the silent output file by the cluster application.

We also recommend the use of the Calibur program for clustering models.  See http://www.biomedcentral.com/1471-2105/11/25 and http://sourceforge.net/projects/calibur/


Tips
====

The AbinitioRelax application performs best for small monomeric proteins that are less than 100 residues in length. It is possible to get accurate predictions for some proteins up to around 150 residues, however, larger proteins require significantly more computing as the conformational space is vastly increased. It is not uncommon to sample in the range of 20,000 to 200,000 models in order to converge towards the native structure. The following references provide information relevant to the sampling problem:

-   Bradley P, Misura KM, Baker D (2005). Toward high-resolution de novo structure prediction for small proteins. *Science* 309, 1868-71.
-   Kim DE, Blum B, Bradley P, Baker D (2009). Sampling bottlenecks in de novo protein structure prediction. *J Mol Biol* 393, 249-60.

Abinitio works well with user-supplied constraints from experiment, using the flags -cst\_file \$filename and -cst\_weight \#weight. See the documentation about [[contraint files|constraint-file]] for more information.

Bioinformatics
--------------

As stated above, it is beneficial to try to identify homologous sequences to run along with the target sequence (see Bradley *et al* reference). Homologs can be identified using search tools like PSI-BLAST to search the non-redundant sequence database (NCBI nr database) or Pfam. Using a sequence alignment viewer like Jalview is very useful to help select an optimal set of homologs to run and also to aid in model selection. Typically we look for a diverse set of homologs (up to 10) with differences in conserved positions and deletions which may represent a truncated loop or disordered region. Small changes in sequence can have a large impact on the topologies that are sampled, for example, a polar residue at a conserved hydrophobic position can have a big effect, i.e. the native topology may not be sampled because the full-atom Rosetta score will highly disfavor a polar residue buried in a hydrophobic core. It is also important to identify and trim disordered termini using publicly available programs like Disopred or metaPrDOS. Signal sequences should also be identified and trimmed using publicly available programs like SignalP. This protocol is not developed for membrane proteins. If transmembrane helices are predicted using programs like TMHMM, please refer to our [[Membrane ab initio|membrane-abinitio]] application.

Expected Outputs
================

Generates pdb files and an energy file, or a silent output file. Example: `       rosetta_demos/abinitio/input_files/S_00000001.pdb      ` , `       rosetta_demos/abinitio/input_files/score.fsc      ` , and `       rosetta_demos/abinitio/output_files/default.out      ` (silent output file).

Post Processing
===============

We recommend generating up to 20,000 to 30,000 models of the target sequence and of up to 10 homologs and then using the [[Cluster application|cluster]] or [Calibur](http://sourceforge.net/projects/calibur/) to identify the most frequently sampled conformations. In a general case, at least one of the top 5-10 clusters by size may have models with the lowest rmsd to the native structure.

In an ideal case, your sequence will have many homologs identified by search tools like PSI-BLAST. Sequence alignments can be extremely helpful in model selection. For example, conserved hydrophobic positions most likely represent the core of the protein so models that have sidechains exposed in such positions may be discarded. The same logic applies to conserved polar positions which are most likely on the surface. Additionally, conserved cysteine pairs may represent disulphides. Tools like Jalview to view alignments and PyMOL to view models are extremely helpful for model selection in this respect.

Score versus RMSD plots may be helpful for identifying convergence towards the native structure for the target sequence and homologs. For example, the lowest scoring model can be used for the `       -in:file:native      ` input option when rescoring models with the [[score.linuxgccrelease|score-commands]] score application. A score versus RMSD plot from the resulting score file may show convergence (an energy funnel) towards the lowest scoring model. If an energy funnel exists, the lowest scoring model has a greater chance of being near-native.  See https://www.rosettacommons.org/node/3813 and https://www.rosettacommons.org/content/how-make-benchmark for discussions on creating Score vs RMSD plots.  The [[PyRosetta Toolkit GUI]] can also be used for score vs RMSD output and obtaining the set of lowest energy structures found during a run 

Lowest scoring models that are in a cluster and that have a topology represented in the PDB also have a greater chance of being correct. Structure-structure comparison tools like Dali or Mammoth can be used to search against the PDB database.


##See Also

* [Introductory Ab Initio Protocol Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/denovo_structure_prediction/Denovo_structure_prediction)
* [Protein Folding using the Broker Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_denovo_structure_prediction/folding_tutorial)
* [[Abinitio]]: Further details on this application
* [[Fasta file]]: Fasta file format
* [[Fragment file]]: Fragment file format (required for abinitio structure prediction)
* [[ROBETTA (external link)|http://robetta.bakerlab.org/]]: Server that provides *ab initio* folding and structure prediction, as well as fragment picking, for academic users
* [[Structure prediction applications]]: A list of other applications to be used for structure prediction
  * [[NonlocalAbinitio]]: Application for predicting protein structure given some prior structural information
  * [[Membrane abinitio]]: Ab initio for membrane proteins.  
  - [[Comparative modeling|minirosetta-comparative-modeling]]: Build structural models of proteins using one or more known structures as templates for modeling (uses the minirosetta application).
    * [[Minirosetta]]: More information on the minirosetta application.
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