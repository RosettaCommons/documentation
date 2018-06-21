#RNA Applications

These applications are specifically designed to work with RNA or RNA-protein complexes. For more information on working with RNA in Rosetta, see the [[Working with RNA|RNA]] page.


###RNA Structure Prediction

* [[3D RNA structure prediction|rna-denovo-setup]]: Predict 3-dimensional structures of RNA from their nucleotide sequence. Read this first.
* [RiboKit](https://ribokit.github.io/workflows/3D_modeling/) What experiments & analysis to do to obtain 3D RNA models.
* [[RNA motif prediction|rna-denovo]]: Model RNA motifs with fragment assembly of RNA with full atom refinement (FARFAR).
* [[RNA stepwise loop enumeration|swa-rna-loop]]: Build RNA loops using *deterministic* stepwise assembly.
* [[Stepwise monte carlo|stepwise]]: Stochastic version of stepwise assembly used to generate 3D models of proteins, RNA, and protein/RNA loops, motifs, and interfaces. This application is not exclusively for RNA but is compatible. 
*  [[RNA assembly with experimental constraints|rna-assembly]] - Predict 3-dimensional structures of large RNAs with the help of experimental constraints. Note – largely deprecated by newer pipeline (described in this [paper](https://daslab.stanford.edu/site_data/pub_pdf/2015_Cheng_MethEnzym.pdf) and [demo](https://www.rosettacommons.org/demos/latest/public/mohca_seq/README)).
* [[CS Rosetta RNA]]: Refines and scores an RNA structure using NMR chemical shift data.  
* [[DRRAFTER]]: Builds RNA coordinates into cryoEM maps of RNA-protein assemblies.
* [[Structure prediction of RNA-protein complexes|rnp-modeling]]: Predict 3D structures of RNA-protein complexes.

###RNA Design

* [[RNA design]]: Optimize RNA sequence for fixed backbones.  

###RNA Analysis

* [[RECCES]]: RNA free energy calculation with comprehensive sampling.
* [[rnp ddg]]: Calculate relative binding affinities for RNA-protein complexes with the Rosetta-Vienna ΔΔG method.

###RNA Utilities

* [[RNA tools]]: A collection of tools for PDB editing, cluster submission, "silent file" processing, and setting up rna_denovo and ERRASER jobs.
* [[ERRASER]]: Refine an RNA structure given electron density constraints.  
* [[RNA pharmacophore]]: Extract and cluster the key features present in RNA (rings, hbond donors & acceptors) from the structure of a protein-RNA complex.
* [[RNA threading|rna-thread]] - Thread a new nucleotide sequence on an existing RNA structure.  
* [[Sample around nucleobase]]: Generates tables of interaction energies between an adenosine nucleobase and a user-specified probe.
* [[RNA score]]: a simple scoring application with hooks into preferred RNA workflows. Not superior to `score_jd2` intrinsically, but usually more convenient.

##See Also
* [RiboKit](https://ribokit.github.io) General workflows for RNA modeling & analysis
* [[Application Documentation]]: Home page for application documentation
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Structure Prediction Applications]]: List of structure prediction applications
* [[Design Applications]]: List of design applications
* [[Analysis Applications]]: List of analysis applications
* [[Utilities Applications]]: List of utilities applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
