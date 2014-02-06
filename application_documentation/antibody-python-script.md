#RosettaAntibody3: a). The PreProcessing Python Script

Metadata
========

Author: Jianqing Xu (xubest@gmail.com), Daisuke Kuroda (dkuroda1981@gmail.com), Oana Lungu (olungu@utexas.edu), Jeffrey Gray (jgray@jhu.edu)

Last edited 4/25/2013. Corresponding PI Jeffrey Gray (jgray@jhu.edu).

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
Options of the script:
  -h, --help            show this help message and exit
  --light-chain=LIGHT_CHAIN
                        Specify the light chain.
  --heavy-chain=HEAVY_CHAIN
                        Specify the heavy chain.
  --prefix=PREFIX       Prefix for output files. Should be dir name. Default
                        is ./ string.
  --blast=BLAST         Specify path+name for 'blastall' executable. Default
                        is blastp [blast+].
  --profit=PROFIT       Specify path+name for 'ProFIt' executable. Default is
                        profit.
  --blast-database=BLAST_DATABASE
                        Specify path of blast database dir.
  --antibody-database=ANTIBODY_DATABASE
                        Specify path of antibody database dir.
  --rosetta-database=ROSETTA_DATABASE
                        Specify path of rosetta database dir.
  --rosetta-bin=ROSETTA_BIN
                        Specify path to 'rosetta_source/bin' dir where
                        antibody_assemble_CDRs', idealize and relax executable
                        expected to be found. Default is '<script
                        location>/bin' (plasce symlink there) and if not found
                        corresponding steps will be skipped.
  --rosetta-platform=ROSETTA_PLATFORM
                        Specify full extra+compier+build type for rosetta
                        biniaries found in --rosetta-bin. For example use
                        static.linuxgccrelease for static build on Linux.
                        Default is dynamic release build of current OS
  --idealize=IDEALIZE   Specify if idealize protocol should be running on
                        final model [0/1]. (default: 0, which mean do not run
                        idealize protocol)
  --relax=RELAX         Specify if relax protocol should be running on final
                        model [0/1]. (default: 1, which mean run relax
                        protocol)
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
  --filter-by-sequence-length=FILTER_BY_SEQUENCE_LENGTH
                        Boolen option [0/1] that control filetering results
                        with filter_by_sequence_length function.
  --filter-by-template-bfactor=FILTER_BY_TEMPLATE_BFACTOR
                        Boolen option [0/1] that control filetering results
                        with filter_by_template_bfactor function.
  --filter-by-outlier=FILTER_BY_OUTLIER
                        Boolen option [0/1] that control filetering results
                        with filter_by_outlier function.
  --filter-by-template-resolution=FILTER_BY_TEMPLATE_RESOLUTION
                        Boolen option [0/1] that control filetering results
                        with filter_by_template_resolution function.
  --filter-by-alignment-length=FILTER_BY_ALIGNMENT_LENGTH
                        Boolen option [0/1] that control filetering results
                        with filter_by_alignment_length function.
```

New things since last release
=============================

This is the first public release in Rosetta3

-   Supports the modern job distributor (jd2).
-   Support for [[constraints|constraint-file]] .

