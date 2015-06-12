#RosettaDNA application

Metadata
========

Author:
Justin Ashworth (ashwortj@uw.edu) , James Havranek (havranek@genetics.wustl.edu) , Phil Bradley (pbradley@fhcrc.org) , Carlos Duarte, David Baker (dabaker@uw.edu)

Last updated 2011-02-18. Corresponding authors are Justin Ashworth and David Baker.

Code and Demo
=============

-   Application source code: `        src/apps/public/RosettaDNA/RosettaDNA.cc       `
-   Primary protocol classes: `        src/protocols/dna/       `
-   Fast tests and demos: `        test/integration/tests/dna_interface_design/       `
-   Scientific tests: `        test/scientific/cluster/dna_interface_design/       `

To run the demos (integration tests), obtain the source package, enter directory main/tests/integration, and run the command line:

```
./integration.py dna_interface_design
```

(note: run ./integration.py -h to set additional options and paths that may be necessary depending on your system)

References
==========

-   Ashworth J, Taylor GK, Havranek JJ, Quadri SA, Stoddard BL, Baker D. Computational reprogramming of homing endonuclease specificity at multiple adjacent base pairs. Nucleic Acids Res. 2010 Sep;38(16):5601-8. PMID:20435674
-   Thyme SB, Jarjour J, Takeuchi R, Havranek JJ, Ashworth J, Scharenberg AM, Stoddard BL, Baker D. Exploitation of binding energy for catalysis and design. Nature. 2009 Oct 29;461(7268):1300-4. PMID:19865174
-   Ashworth J, Baker D. Assessment of the optimization of affinity and specificity at protein-DNA interfaces. Nucleic Acids Res. 2009 Jun;37(10):e73. PMID:19389725
-   Ashworth J, Havranek JJ, Duarte CM, Sussman D, Monnat RJ Jr, Stoddard BL, Baker D. Computational redesign of endonuclease DNA binding and cleavage specificity. Nature. 2006 Jun 1;441(7093):656-9. PMID:16738662

Purpose
===========================================

This application provides support for biophysical modeling of protein-DNA interactions. It provides sampling and energetic estimates of structural and mutational degrees of freedom in the protein-DNA interface.

Algorithm
=========

This application is provided to access full-atom, primarily fixed-backbone protocols in the protocols/dna directory through the RosettaScripts and Job Dsitributor schemes. This scheme is highly extensible: this application also provides access to any other class or procedure that is implemented under the RosettaScripts scheme. Currently, the primary difference between this application and the RosettaScripts application is that this one uses a custom JobOutputter class to prepend protein-DNA-specific information to output PDB files.

Limitations
===========

This application is not officially supported for anything that is not described in the referenced literature citations.

Modes
=====

Please see the demos (integration tests) for three example modes for this application. Three modes are provided: automated basepair-specific design, resfile-directed design, and basepair specificity prediction.

Input Files
===========

Required file
-------------

-   A PDB structure of a protein-DNA interface. Note: many structures contain non-canonical amino acids and nucleotides. You will need to substitute these with normal types using a method of your choice.
-   A RosettaScripts XML-like protocol file. Examples are provided in the demos (integrations tests). Please see the RosettaScripts documentation for more details.

Optional additional files:
--------------------------

-   A resfile. This is a file that explicitly specifies residue-level behaviors. It is only applied if the appropriate ResfileReader TaskOperation is employed in the RosettaScript. An example is provided (see paths in section Files).

Options
=======

Basic protocol options
-------------------------

Most protocol-specific behavior is specified through the RosettaScripts interface. Here are examples of the primary class options:

-   `        <RestrictDesignToProteinDNAInterface name="DnaInt" base_only="1" z_cutoff="3.0" dna_defs="C.-10.GUA/">       ` This class automatically detects the relevant amino acids to move and mutate (those near DNA). base\_only: should backbone contacts be considered?; z\_cutoff: distance cutoff for contact to a certain basepair, measured along the DNA helical axis; dna\_defs: which base pairs to consider (uses PDB chain id and numbering).
-   `        <DNA weights="dna/">       ` sets the weights file for the internal score function.
-   `        <DnaInterfaceMultiStateDesign name="msd" scorefxn="DNA" task_operations="IFC,IC,AUTOprot,DnaInt" pop_size="20" num_packs="1" numresults="0" boltz_temp="2" anchor_offset="15" mutate_rate="0.8" generations="5/">       ` This class performs multi-state design of amino acids for improved descrimination between seqquences. This functionality is not officially supported. pop\_size: number of different protein sequences; num\_packs: number of packing trials per sequence; numresults: number of results to return; boltz\_temp: the Boltzmann temperature factor to use when effectively comparing energy fitnesses; anchor\_offset: approximate number of energy units that can be traded in order to gain specificity; mutate\_rate: rate of mutation for a single sequence; generations: number of times to "evolve" set of sequences.
-   `        <DesignProteinBackboneAroundDNA name="bb" scorefxn="DNA" task_operations="IFC,IC,AUTOprot,DnaInt" type="ccd" gapspan="4" spread="3" cycles_outer="3" cycles_inner="1" temp_initial="2" temp_final="0.6/">       ` This class tries to introduce small local changes in backbone structure. gapspan and spread determine how much of the backbone is made flexible (spread refers to the number of backbone residues on either side of each DNA-contacting residue, and gapspan sets the number of amino acids between spreads that results in their concatenation). cycles\_outer and cycles\_inner set the number of times to samplee possible backbone conformations. temp\_initial and temp\_final affect the starting and ending acceptance rates of backbone changes that increase free energy (higher numbers: higher acceptance rates and thus more aggressive and potentially destabilizing changes).
-   `        <DnaInterfacePacker name="DnaPack" scorefxn="DNA" task_operations="IFC,IC,AUTOprot,ProtNoDes,DnaInt" binding="1" probe_specificity="1/">       ` This class controls the fixed-backbone packing stage of the protocol. task\_operations: this specifies all of the RosettaScripts-specified TaskOperations that specify the behavior of the packer (see the full script in the demos (integration tests) for examples of these). binding: this option sets whether binding energies are calculated (0: no, 1: yes). probe\_specificity: sets whether the basepair specificity of the protein is calculated after the packer has finished altering the interface. Please see the demos and RosettaScripts documentation for more details.

General Options
---------------

The following general Rosetta command-line options are currently used in demos:

-   `        -adducts dna_major_groove_water       ` activates hydrated nucleotides
-   `        -sparse_pdb_output       ` only write PDB lines for residues that differ from input structure (to reduce disk space and memory sizes)
-   `        -file:s [your.pdb]       ` specifies input structure file
-   `        -in:ignore_unrecognized_res       ` this options toggles failure upon encountering an unkown residue in the input file
-   `        -score:weights dna       ` sets scorefunction weights for output structure (separate (but preferably the same as) scorefunction weights specified in the RosettaScripts file).
-   `        -use_input_sc       ` toggles inclusion of original sidechain orientations in conformational sampling.
-   `        -run:output_hbond_info       ` adds hydrogen bonding information to the output file
-   `        -score:output_residue_energies       ` adds residue energies to output file
-   `        -jd2:dd_parser       ` required option for RosettaScripts
-   `        -parser:protocol design.script       ` specifies protocol file for RosettaScripts
-   `        -overwrite       ` overwrites old output files when re-run
-   `        -out:prefix design_       ` output file prefix

Tips
====

The demos (integration tests) are designs to run quickly. For higher quality results, additional rotamer sampling can be enabled using the -ex1 and -ex2 command line options. Also, see the scientific tests (mentioned earlier in this documentation under Files) for more useful parameters.

Optimal performance depends upon a few minor modifications of the code and database files. For this reason, alternative database files are provided in test/scientific/cluster/dna\_interface\_design/rosetta\_database\_sparse/. The modifications are summarized below:

-   increasing the rotamer probability cutoff in SingleResidueDunbrackLibrary::probability\_to\_accumulate\_while\_building\_rotamers (-dunbrack\_prob\_buried and -dunbrack\_prob\_nonburied options)
-   eliminating protein-DNA hydrogen bond strength attenuation on the basis of number of neighbors (use NO\_ENV\_HB\_DEP\_DNA option in weights files)
-   reducing the hydrogen radii in rosetta\_database\_sparse/chemical/atom\_type\_sets/fa\_standard/atom\_properties.txt to 0.1/0.7 (polar/nonpolar). Still requires manually/ changing/customizing database files.

Expected Outputs
================

These protocols output files through the JobDistributor scheme. Normally, this results in a PDB file. Often, this PDB file will contain header information that describes the results of the analysis.

##See Also

* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
