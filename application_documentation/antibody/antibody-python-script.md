# RosettaAntibody3: The PreProcessing Python Script

Metadata
========

Author: Jianqing Xu (xubest@gmail.com), Daisuke Kuroda (dkuroda1981@gmail.com), Oana Lungu (olungu@utexas.edu), Jeffrey Gray (jgray@jhu.edu)

Corresponding PI Jeffrey Gray (jgray@jhu.edu).

Last edited 9/28/2014 by Jared Adolf-Bryfogle. 

References
==========

We recommend the following articles for further studies of RosettaDock methodology and applications:

-   J. Xu, D. Kuroda & J. J. Gray, “RosettaAntibody3: Object-Oriented Designed Protocol and Improved Antibody Homology Modeling.” (2013) in preparation
-   A. Sivasubramanian,\* A. Sircar,\* S. Chaudhury & J. J. Gray, "Toward high-resolution homology modeling of antibody Fv regions and application to antibody-antigen docking," Proteins 74(2), 497-514 (2009)

Application purpose
===========================================

This is a python script for pre-processing for the antibody protocol (developer only repository): [https://svn.rosettacommons.org/source/trunk/antibody/scripts.v2/](https://svn.rosettacommons.org/source/trunk/antibody/scripts.v2/)

The script consists of 3 main steps:

1.  templates selection by BLAST,
2.  grafting by Rosetta executable
3.  optimize the grafted model by Rosetta protocols. In the step 3, FastRelax w/ all-atom constraint is used. this step make template Phi/Psi values better.

**Inputs:**

1.  Sequence of the light chain Fv in FASTA format
2.  Sequence of the heavy chain Fv in FASTA format

Also, you can specify templates by using options –L1=\<PDB ID 1\>, –L2=\<PDB ID 2\> etc. See all options below.

**Outputs:**

1.  Sequence-grafted and refined Fv pdb: grafted.pdb, grafted.relaxed.pdb
2.  Constraints file for optional use in Step 3: cter\_constraint

**Minimal usage:**

```
./antibody.py --light-chain <input_l.fasta> --heavy-chain <input_h.fasta> --blast=<blast> --blast-database=<blast_database>
```

The final outputs are below. In this case, you have to graft templates by yourself. FR.pdb (FR template and CDR dummy coordinates) L1.pdb, L2.pdb, L3.pdb, H1.pdb, H2.pdb, H3.pdb (template of each CDR)

**Complete usage for grafting:**

```
./antibody.py --light-chain <input_l.fasta> --heavy-chain <input_h.fasta> --profit=<ProFit> --blast=<blast> --blast-database=<blast_database> --antibody-database=<antibody_database> --rosetta-bin=<rosetta/rosetta_sourse/bin> --rosetta-database=<rosetta_database> 
```

The final outputs are below.

1.  grafted.pdb (grafted model)
2.  grafted.relaxed.pdb (grafted relaxed model)
3.  cter\_constraint (kink/extend constraint file)

Options
=======

```
Usage: antibody.py [OPTIONS] [TESTS]

 Script for preparing detecting antibodys and preparing info for Rosetta
protocol.

Options:
  -h, --help            show this help message and exit
  -L LIGHT_CHAIN, --light-chain=LIGHT_CHAIN
                        Specify file with the light chain - pure IUPAC ASCII
                        letter sequence, no FASTA headers.
  -H HEAVY_CHAIN, --heavy-chain=HEAVY_CHAIN
                        Specify file with the heavy chain - pure IUPAC ASCII
                        letter sequence, no FASTA headers.
  --prefix=PREFIX       Prefix for output files (directory name). Default is
                        grafting/.
  --blast=BLAST         Specify path+name for 'blastall' executable. Default
                        is blastp [blast+].
  --superimpose-profit=SUPERIMPOSE_PROFIT
                        (default).  Add full path as argument if necessary.
  --superimpose-PyRosetta, --superimpose-pyrosetta
                        Use PyRosetta to superimpose interface (boolean)
  --blast-database=BLAST_DATABASE
                        Specify path of blast database dir.
  --antibody-database=ANTIBODY_DATABASE
                        Specify path of antibody database dir. Default:
                        script_dir/antibody_database.
  --rosetta-database=ROSETTA_DATABASE
                        Specify path of rosetta database dir.
  -x, --exclude-homologs
                        Exclude homologs with default cutoffs
  --homolog_exclusion=HOMOLOG_EXCLUSION
                        Specify the cut-off for homolog exclusion during CDR
                        or FR template selections.
  --homolog_exclusion_cdr=HOMOLOG_EXCLUSION_CDR
                        Specify the cut-off for homolog exclusion during CDR
                        template selections.
  --homolog_exclusion_fr=HOMOLOG_EXCLUSION_FR
                        Specify the cut-off for homolog exclusion during FR
                        template selections.
  --rosetta-bin=ROSETTA_BIN
                        Specify path to 'rosetta/source/bin' directory,
                        expected to harbor 'antibody_graft', 'idealize' and
                        'relax' executables. Default is
                        '$ROSETTA/main/source/bin, then <script location>/bin'
                        (place symlink there). If a particular executable is
                        not found and that is non-critical, corresponding
                        steps will be skipped.
  --rosetta-platform=ROSETTA_PLATFORM
                        Specify full extra+compiler+build type for rosetta
                        binaries found in --rosetta-bin. For example use
                        static.linuxgccrelease for static build on Linux.
                        Default are dynamic GCC release builds of the OS
                        executing the script.
  --idealize            Use idealize protocol on final model.
  --constant-seed       Use constant-seed flag in Rosetta grafting run (for
                        debugging).
  --idealizeoff, --noidealize
                        Do not use idealize protocol on final model. (default)
  --relax               Use relax protocol on final model. (default)
  --relaxoff, --norelax
                        Do not use relax protocol on final model.
  --skip-kink-constraints
                        Skip generation of kink constraints file (require
                        PyRosetta). Default is True.
  --timeout=TIMEOUT     Maximum runtime for rosetta relax run (use 0 for
                        unlimit), default is 900 - 15min limit
  -q, --quick           Specify fast run (structure will have clashes).
                        Prevents stem optimization and turns off relax,
                        idealize.
  --FRL=FRL             Specify path or PDB code for FRL template. If
                        specified this will overwrite blast selection.
  --FRH=FRH             Specify path or PDB code for FRH template. If
                        specified this will overwrite blast selection.
  --light=LIGHT         Specify path or PDB code for light template. If
                        specified this will overwrite blast selection.
  --heavy=HEAVY         Specify path or PDB code for heavy template. If
                        specified this will overwrite blast selection.
  --L1=L1               Specify path or PDB code for L1 template. If specified
                        this will overwrite blast selection.
  --L2=L2               Specify path or PDB code for L2 template. If specified
                        this will overwrite blast selection.
  --L3=L3               Specify path or PDB code for L3 template. If specified
                        this will overwrite blast selection.
  --H1=H1               Specify path or PDB code for H1 template. If specified
                        this will overwrite blast selection.
  --H2=H2               Specify path or PDB code for H2 template. If specified
                        this will overwrite blast selection.
  --H3=H3               Specify path or PDB code for H3 template. If specified
                        this will overwrite blast selection.
  --light_heavy=LIGHT_HEAVY
                        Specify path or PDB code for light_heavy template. If
                        specified this will overwrite blast selection.
  --self-test           Perform self test by using data in test/ dir and exit.
  --self-test-dir=SELF_TEST_DIR
                        Specify path for self test dir [default:self-test/].
  -v, --verbose         Generate verbose output.
  --filter-by-outlier=FILTER_BY_OUTLIER
                        Boolean option [0/1] that control filetering results
                        with filter_by_outlier function.
  --filter-by-sequence-length=FILTER_BY_SEQUENCE_LENGTH
                        Boolean option [0/1] that control filetering results
                        with filter_by_sequence_length function.
  --filter-by-alignment-length=FILTER_BY_ALIGNMENT_LENGTH
                        Boolean option [0/1] that control filetering results
                        with filter_by_alignment_length function.
  --filter-by-template-resolution=FILTER_BY_TEMPLATE_RESOLUTION
                        Boolean option [0/1] that control filetering results
                        with filter_by_template_resolution function.
  --filter-by-sequence-homolog=FILTER_BY_SEQUENCE_HOMOLOG
                        Boolean option [0/1] that control filetering results
                        with filter_by_sequence_homolog function.
  --filter-by-template-bfactor=FILTER_BY_TEMPLATE_BFACTOR
                        Boolean option [0/1] that control filetering results
                        with filter_by_template_bfactor function.

```

New things since last release
=============================

This is the first public release in Rosetta3

-   Supports the modern job distributor (jd2).
-   Support for [[constraints|constraint-file]] .

##See Also

* [[Antibody protocol]]: Application associated with this script
* [[General Antibody Options and Tips]]
* [[Antibody Applications]]: Homepage for antibody applications
    * [[Grafting CDR loops|antibody-assemble-cdrs]]: Graft antibody CDR templates on the framework template to create a rough antibody model.  
    * [[Modeling CDR H3|antibody-model-CDR-H3]]: Determine antibody structures by combining VL-VH docking and H3 loop modeling.
    - [[Camelid antibody docking|antibody-mode-camelid]]: Dock camelid antibodies to their antigens.
    - [[SnugDock | snugdock]]: Paratope structure optimization during antibody-antigen docking
    * [[Antibody Design Strategy Analysis]]: A PyRosetta-based tool to analyze and/or compare antibody design strategies.

    * [[CDR Cluster Identification]]: An application that matches each CDR of an antibody to North/Dunbrack CDR clusters based on the lowest dihedral distance to each cluster center.

     * [[CDR Cluster Constrained Relax]]: An application to relax CDRs using circular harmonic constraints based on identified CDR clusters.
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
