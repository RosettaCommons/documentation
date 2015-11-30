#RosettaCM - Comparative Modeling with Rosetta

Metadata
========

Documentation by Sebastian Rämisch (raemisch@scripps.edu) and Jared Adolf-Bryfogle (jadolfbr@gmail.com)

Purpose
=======

This protocol functions to create a homology model or combined model of several different PDBs and templates.  It is used for comparative modeling of proteins.  

References
==========

[High-resolution comparative modeling with RosettaCM](http://www.sciencedirect.com/science/article/pii/S0969212613002979).  
Song Y, DiMaio F, Wang RY, Kim D, Miles C, Brunette T, Thompson J, Baker D.,
Structure. 2013 Oct 8;21(10):1735-42. doi:10.1016/j.str.2013.08.005. Epub 2013 Sep 12.

## Algorithm

The first step of the protocol is to thread the same sequence onto one or multiple templates.  These templates can be homologous proteins or the same proteins from multiple crystal structures.  The second step is to use the [[HybridizeMover]] through [[RosettaScripts]] to create a single model from the template(s) using foldtree hybridization, sampling regions from each template, and loop closure through cartesian minimization. 

## Step One - Threading  
First we need to produce template pdb files for Rosetta by threading the target sequence onto one or several template protein structures.
### Input Files
* Sequence alignment file in Grishin format
* Template PDB file(s)
* Target sequence fasta file

*Important*  
The output files will be named after the corresponding name in the Grishin alignment file. Furthermore, this anem has to be at least 5 characters long. If your name in the alignment file is the same as your input file name, **the input file will be overwritten!**  
The best is to write "XXXX_templ" in the alignment file. This will produce XXXX_templ.pdb.   

Example: (hsIGF = target name; 1k3d = template name)

    ## hsIGF 1k3d.templ
    #
    scores_from_program: 0
    0 KVTVDTVCKRGFLIQMSGHLECKCEND-VLVNEETCEEKVLKCDE
    0 AVTVDTICKNGQLVQMSNHFKCMCNEGLVHLSENTCEEKN-CKKE

    ## hsIGF 1y12.templ
    #
    scores_from_program: 0
    0 DVTVETVCKRGNLIQRSG---CKCENDLVLVNHETCEEKVLKCDL
    0 AVTVDTICKNGQLVQMSNHFKCMCNEGLVHLSENTCEEKN-CKKE

Several alignments should be written to the *same* alignment file.

If your alignment starts at a different position in the template, you can change the numbers at left of the format or add - where they need to be.

    ## 1xxx 1yyy.pdb
    # hhsearch
    scores_from_program: 1.0 0.0
    7 AAAAAAA
    0 AAAAAAA
    --

    Alternately, you can add the N term residues unaligned to the ali:
    ## 1xxx 1yyy.pdb
    # hhsearch
    scores_from_program: 1.0 0.0
    0 AAAAAAAAAAAAAA
    0 -------AAAAAAA


###Command:

    partial_thread.linuxclangrelease -database /.../database -in:file:fasta target.fasta -in:file:alignment alignment.aln -in:file:template_pdb 1k3d.pdb 1y12.pdb -ignore_unrecognized_res

This application should only take some seconds.

## Step Two - Hybridize
This is the actual modeling step.
### Input Files
* RosettaScripts xml file
* target sequence fasta file
* threaded template pdb files from Step 1

Example xml file:

    <ROSETTASCRIPTS>
    <TASKOPERATIONS>
    </TASKOPERATIONS>
    <SCOREFXNS>
        <stage1 weights=score3 symmetric=0>
            <Reweight scoretype=atom_pair_constraint weight=0.5/>
        </stage1>
        <stage2 weights=score4_smooth_cart symmetric=0>
            <Reweight scoretype=atom_pair_constraint weight=0.5/>
        </stage2>
        <fullatom weights=talaris2013_cart symmetric=0>
            <Reweight scoretype=atom_pair_constraint weight=0.5/>
        </fullatom>
    </SCOREFXNS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <Hybridize name=hybridize stage1_scorefxn=stage1 stage2_scorefxn=stage2 fa_scorefxn=fullatom batch=1 stage1_increase_cycles=1.0 stage2_increase_cycles=2.0  linmin_only=1>
            <Template pdb="1k3d_templ.pdb" cst_file="AUTO" weight=1.000 />
            <Template pdb="1y12_templ.pdb" cst_file="AUTO" weight=1.000 />
        </Hybridize>
    <FastRelax name="relax" scorefxn=talaris2013  />

    </MOVERS>
    <APPLY_TO_POSE>
    </APPLY_TO_POSE>
    <PROTOCOLS>
        <Add mover=hybridize/>
        <Add mover=relax/>
    </PROTOCOLS>

  <OUTPUT scorefxn=talaris2013 />
</ROSETTASCRIPTS>



###Options

    -database                       # Path to database
    -parser:protocol                # xml protocol file name
    -in:file:fasta                  # target sequence
    -nonideal
    -dualspace
    -use_input_sc
    -ex1
    -ex2

###Command:

rosetta_scripts.linuxclangrelease @options

Tips
====

Post Processing
===============
Using the cluster application helps to analyze the results.  
See [[Analyzing Results]]: Tips for analyzing results generated using Rosetta

##See Also

* [[RosettaScripts]] documentation
* [[HybridizeMover]]: The Hybridize Mover used by RosettaCM
* [[Structure prediction applications]]: A list of other applications to be used for structure prediction
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files