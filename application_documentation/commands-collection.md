#Command lines collection for pilot/public applications

Metadata
========

This document was edited Nov 10th 2008 by Yi Liu. Credits go to developers who helped me to collect these useful command lines.

Instructions
============

-   There are no specific examples for every pilot applications in the rosetta trunk yet.
-   Make sure that you have the application in the pilot\_apps.src.settings.
-   Or, you can build all pilot applications with the scons flag pilot\_apps\_all

Command lines collected from Firas
==================================

Please read the options list to find the descriptions for each option in the commands

-   backrub:

    ```
    path/to/rosetta/source/bin/backrub.linuxgccrelease -s 1cc8_model15.pdb -ex1 -ex2aro -ex1aro -backrub:pivot_residues 10 11 12 13 14 15 -packing:resfile Resfile -backrub:ntrials 5000 -backrub:mc_kt 1.0 -database path/to/rosetta/main/database/ -out:nstruct 1000
    ```

-   scoring with rosetta:

    ```
    path/to/rosetta/source/bin/backrub.linuxgccrelease -s 1cc8_model15.pdb -ex1 -ex2aro -ex1aro -backrub:pivot_residues 10 11 12 13 14 15 -packing:resfile Resfile -backrub:ntrials 5000 -backrub:mc_kt 1.0 -database path/to/rosetta/main/database/ -out:nstruct 1000
    ```

-   scoring with rosetta:

    ```
    path/to/rosetta/source/bin/backrub.linuxgccrelease -s 1cc8_model15.pdb -ex1 -ex2aro -ex1aro -backrub:pivot_residues 10 11 12 13 14 15 -packing:resfile Resfile -backrub:ntrials 5000 -backrub:mc_kt 1.0 -database path/to/rosetta/main/database/ -out:nstruct 1000
    ```

-   relax with rosetta:

    ```
    path/to/rosetta/source/bin/relax.linuxgccrelease -database /path/to/rosetta/main/database/  -score:weights score13_env_hb -out:pdb -out:prefix relaxed -out:nstruct 100 -in:file:s 1utg_model39.pdb 
    ```

-   relax with constraints in rosetta:

    ```
    /path/to/rosetta/source/bin/relax.linuxgccrelease -database path/to/rosetta/main/database/  -score:weights score13_env_hb -out:pdb -out:prefix constrained -constraints:cst_file constraints_file -constraints:cst_weight 2.0 -out:nstruct 100 -in:file:s 1utg_model39f.pdb
    ```

-   loop modeling with constraints:

    ```
    add -constraints:cst_fa_file and -constraints:cst_fa_weight
    cst_weight can be higher (up to 10, even 100), sample constraints file:
    AtomPair CZ 64 CA 8 GAUSSIANFUNC 6.39 2.0
    ```

-   make a loop

    ```
    path/to/rosetta/source/bin/minirosetta.linuxgccrelease @args
    ```
    with args file:
    ```
    -in::file::s  threaded-model.pdb
    -database /path/to/rosetta/main/database/
    -loops::frag_sizes 9 3 1
    -loops::frag_files aat000_09_05.200_v1_3 aat000_03_05.200_v1_3 none
    -loops::loop_file t000_.loopfile
    -score:weights score13_env_hb
    -psipred_ss2 fragments/t000_.psipred_ss2
    -run::protocol looprelax
    -loops::remodel quick_ccd
    -loops::relax fullrelax
    -out::nstruct 100
    -in:file:fullatom
    -out::pdb
    -out::prefix lr_decoys
    ```

-   packstate:

    ```
    /path/to/rosetta/source/bin/packstat.linuxgccrelease -database /path/to/rosetta/main/database -packstat:packstat_pdb -s 1shf.pdb
    ```

Command lines collected from Steven Lewis
=========================================

####The following are example flags files. The associated applications are deprecated, documented elsewhere, or are not available for public use; these are intended only as generic examples.

-   options file for pilot/rjha/MatchFilter.cc

    ```
    -database /path/to/rosetta/main/database
    -options::user
    -run::version
    -mute core
    -l pdblist
    ```

-   options file for pilot/rjha/MetalInterfaceStructureCreator.cc

    ```
    -database /path/to/rosetta/main/database
    -s NE2.pdb
    -run::version
    -options::user
    -resfile resfile
    ```

-   options file for pilot/rjha/MetalInterfaceStructureCreator.cc

    ```
    -database /path/to/rosetta/main/database
    -s NE2.pdb
    -run::version
    -options::user
    -resfile resfile
    -ex1
    -ex2
    -extrachi_cutoff 1
    -use_input_sc
    -run::min_type dfpmin_armijo_nonmonotone
    -nstruct 1
    -AnchoredDesign::perturb_temp 1.0
    -AnchoredDesign::perturb_cycles 500
    -AnchoredDesign::perturb_show
    -AnchoredDesign::refine_cycles 1
    -pose_metrics::interface_cutoff 10
    local options:
    -MetalInterface::partner1 (partner 1, defaults to ank.pdb)
    -MetalInterface::partner2 (partner 2, defaults to ubc12.pdb)
    -MetalInterface::partner2_residue (which residue on ubc12 to replace,defaults to 62)
    -skip_sitegraft_repack
    ```

-   options file for pilot/smlewis/AnchoredDesign.cc

    ```
    -database /path/to/rosetta/main/database
    -mute core.chemical core.scoring.etable core.io.database
    core.io.pdb.file_data core.conformation core.pack.pack_rotamers
    core.pack.task
    -run::version
    -options::user
    -s /netscr/smlewis/18_1F11_design_132cut/1F11_t-1QWF.pdb
    -loops::loop_file loopsfile
    -in::file::frag3/netscr/smlewis/18_1F11_design_132cut/aat000_03_05.200_v1_3.plusSH3.gz
    -resfile /netscr/smlewis/18_1F11_design_132cut/resfile/netscr/smlewis/18_1F11_design_132cut/resfile2
    -ex1
    -ex2 #only later
    -use_input_sc
    -run::min_type dfpmin_armijo_nonmonotone
    -AnchoredDesign::anchor /netscr/smlewis/18_1F11_design_132cut/anchor
    -AnchoredDesign::debug
    -AnchoredDesign::refine_only
    -AnchoredDesign::perturb_show
    -AnchoredDesign::perturb_report 1
    -AnchoredDesign::perturb_temp
    -AnchoredDesign::refine_report 1
    -AnchoredDesign::refine_temp
    -AnchoredDesign::refine_repack_cycles 30
    -constant_seed
    -jran !!!
    -AnchoredDesign::perturb_cycles 300
    -AnchoredDesign::refine_cycles 1000
    -nstruct 334
    ```

Command lines collected from Ben Stranges
=========================================

-   Sarel's dock\_design\_parser

    ```
    -database ../database  (path to database)
    -s pdbname.pdb  (structure to dock/design)
    -parser:protocol protocol_name.protocol  (the file that contains the XML formatted protocol to use)
    -parser:ntrials 10  (number of total times the parser is run)
    -nstruct 5  (total number of possible structures (pdbs) output)
    -parser:view  (gives graphics of protocol; need to compile with extras=graphics for this to work)
    ```

##See Also

* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
* [[Getting Started]]: A page for people new to Rosetta
* [[Scripting Documentation]]: Scripting interfaces to Rosetta
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[TACC]]: Information for running Rosetta on the TACC/Stampede cluster.
