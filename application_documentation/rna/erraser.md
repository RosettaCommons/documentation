#Remodeling RNA crystallographic models with electron density constraint (ERRASER: Enumerative Real-Space Refinement ASsitted by Electron density under Rosetta)

Metadata
========

Author: Fang-Chieh Chou

Mar. 2012 by Fang-Chieh Chou (fcchou [at] stanford.edu).

Code and Demo
=============

The full ERRASER pipeline is controlled by a set of python codes in `       src/apps/public/ERRASER/      ` . The main applications being used are *erraser\_minimizer* , *swa\_rna\_analytical\_closure* and *swa\_rna\_main* . The central codes for SWA (StepWise Assembly) applications are in `       src/protocols/stepwise/legacy/rna/      ` . The electron density scoring function used in ERRASER is in `       src/core/scoring/electron_density_atomwise/      ` .

For a minimal demonstration of ERRASER, see: `       demos/public/ERRASER/      `

References
==========

Chou, F.C., Sripakdeevong, P., Dibrov, S.M., Hermann, T., and Das, R. Correcting pervasive errors in RNA crystallography with Rosetta, arXiv:1110.0276. [For ERRASER. To be published] [Preprint](http://arxiv.org/abs/1110.0276)

Sripakdeevong, P., Kladwang, W., and Das, R. (2011) "An enumerative stepwise ansatz enables atomic-accuracy RNA loop modeling", PNAS 108:20573-20578. [For stepwise assembly algorithm (SWA)] [Paper](http://www.stanford.edu/~rhiju/Sripakdeevong_StepwiseAnsatz_2011.pdf) [Link](http://dx.doi.org/10.1073/pnas.1106516108)

Application purpose
===========================================

This code is used for improving a given RNA crystallographic model and reduce the number of potential errors in the model (which can evaluated by Molprobity), under the constraint of experimental electron density map.

Algorithm
=========

This method pipelines Rosetta full-atom mimization and stepwise assembly rebuilding for single residue to improve a given RNA crystallographic model. Electron density score is used to constrain the model during the modeling.

Limitations
===========

-   ERRASER works only for RNA currently. Other parts in crystallographic model, including proteins, modified bases and ligands, are not being modeled. Remodeling of RNA residues that are in close contact with these components may be problematic. We are planning to tackle these issues in the future, but for now ERRASER seems to be work well for most RNA residues. Residues in close contact with non-RNA components can also be held fixed in ERRASER to avoid problematic rebuilding.

-   Currently crystal contacts are not being modeled, which is known to cause problems in a few test cases when RNA is interacting strongly with its crystal-packing partner (ex. base-pairing and base-stacking). Right now this problem can be resolved by mannually add the crystal-packing partner into the starting pdb file. We are planning to model crystal-packing in the future.

-   The PHENIX refinement package is required for the ERRASER pipeline. The users can download PHENIX from [http://www.phenix-online.org](http://www.phenix-online.org) (free for academic usage)

Modes
=====

There is only one mode to run ERRASER at present.

Input Files
===========

Required files
-------------

You need two files:

-   The starting structure in standard pdb format. The ERRASER directly takes the standard pdb file and convert it to Rosetta format automatically, therefore no pre-processing is required.

-   A CCP4 electron density map file. This can be created by PHENIX or other refinement packages. The input map must be a CCP4 2mFo-DFc map. To avoid overfitting, Rfree reflection should be excluded during the creation of the map file.

Optional additional files:
--------------------------

-   No extra optional file is needed for ERRASER.

How to run the job
------------------

Prior to running ERRASER, the following setup is required:

1.  Download and install PHENIX from [http://www.phenix-online.org/](http://www.phenix-online.org/) . PHENIX is free for academic users.
2.  Ensure you have correctly setup PHENIX. As a check, run the following command and see if it works:

    ```
    phenix.rna_validate
    ```

3.  Check if you have the latest python (v2.7) installed. If not, go to the `        rosetta/rosetta_tools/ERRASER/       ` folder and run

    ```
    ./convert_to_phenix.python
    ```

    This will change the default python used by the code to phenix-built-in python, instead of using system python.

4.  Set up the environmental variable "\$ROSETTA", point it to the Rosetta folder. If you use bash, append the following lines to `        ~/.bashrc       ` :

    ```
    ROSETTA=<YOUR_ROSETTA_PATH>; export ROSETTA
    ```

    Also add the ERRASER script folder to \$PATH. Here is a bash example:

    ```
    PATH=$PATH:<YOUR_ROSETTA_PATH>/rosetta_tools/ERRASER/
    ```

Now you are ready to go!

ERRASER can be simply run with the python script `       erraser.py      ` in the `       rosetta_tools/ERRASER/      ` directory. If you followed the setup instruction above, you should now be able to run ERRASER directly from command line:

```
erraser.py -pdb 1U8D_cut.pdb -map 1U8D_cell.ccp4 -map_reso 1.95 -fixed_res A33-37 A61 A65 
```

The first two arguments are required – the input pdb file and the CCP4 map file. The last two arguments are optional; they supply the map resolution and the residues need to be fixed during rebuilding.

You can see examples of the output pdb file in `       example_output/      ` .

Command-lines in some more detail.
---------------------------

The above workflow should work, but its worth looking at the rosetta command-lines called by the python scripts to see what's going on.

The minimization step:

```
erraser_minimizer.<exe> -database <path to database> -native <input pdb> -out_pdb <output pdb> 
-score::weights rna/rna_hires_elec_dens -score:rna_torsion_potential RNA09_based_2012_new 
-vary_geometry true -fixed_res <fixed residue list> 
-edensity:mapfile <map file> -edensity:mapreso 2.0 -edensity:realign no
```

The rebuilding step with loop closure:

```
swa_rna_analytical_closure.<exe> -database <path to database> -algorithm rna_resample_test -s <input pdb> -native <native pdb> 
-out:file:silent blah.out -sampler_extra_syn_chi_rotamer true -sampler_cluster_rmsd 0.3 -native_edensity_score_cutoff 0.9 
-sampler_native_rmsd_screen true -sampler_native_screen_rmsd_cutoff 2.0 -sampler_num_pose_kept 30 -PBP_clustering_at_chain_closure true 
-allow_chain_boundary_jump_partner_right_at_fixed_BP true -add_virt_root true -sample_res 2 -cutpoint_closed 2  
-fasta fasta -input_res 1 3-4 -fixed_res 1 3-4 -jump_point_pairs NOT_ASSERT_IN_FIXED_RES 1-4 -alignment_res 1-4 -rmsd_res 4 
-score:weights rna/rna_hires_elec_dens -edensity:mapfile <map file> -edensity:mapreso 2.0 -edensity:realign no 
-score:rna_torsion_potential RNA09_based_2012_new
```

The rebuilding step at terminal residue:

```
swa_rna_main.<exe> -database <path to database> -algorithm rna_resample_test -s <input pdb> -native <native pdb> 
-out:file:silent blah.out -sampler_extra_syn_chi_rotamer true -sampler_cluster_rmsd 0.3 -native_edensity_score_cutoff 0.9 
-sampler_native_rmsd_screen true -sampler_native_screen_rmsd_cutoff 2.0 -sampler_num_pose_kept 30 -PBP_clustering_at_chain_closure true 
-allow_chain_boundary_jump_partner_right_at_fixed_BP true -add_virt_root true -sample_res 2 -cutpoint_closed 2 
-fasta fasta -input_res 1-4 -fixed_res 2-4 -jump_point_pairs NOT_ASSERT_IN_FIXED_RES 1-4 -alignment_res 1-4 -rmsd_res 4 
-score:weights rna/rna_hires_elec_dens -edensity:mapfile <map file> -edensity:mapreso 2.0 -edensity:realign no 
-score:rna_torsion_potential RNA09_based_2012_new
```

Options
=======

Below are a list of available arguments for `       erraser.py      ` .

```
Required:

-pdb
Format: -pdb <input pdb>
The starting structure in standard pdb format.

-map
Format: -map <map file>
2mFo-DFc map file in CCP4 format. Rfree should be excluded.

Commonly used:

-map_reso
Format: -map_reso <float> / Default: 2.0
The resolution of the input density map. It is highly recommanded to input the map 
resolution whenever possible for better result.

-out_pdb
Format: -out_pdb <string> / Default: <input pdb name>_erraser.pdb.
The user can output to other name using this option.

-n_iterate
Format: -n_iterate <int> / Default: 1
The number of rebuild-minimization iteration in ERRASER. The user can increase the
number to achieve best performance. Usually 2-3 rounds will be enough. Alternatively,
the user can also take a ERRASER-refined model as the input for a next ERRASER run to
achieve mannual iteration.

-fixed_res
Format: -fixed_res <list> / Default: <empty>
(Example: A1 A14-19 B9 B10-13  #chain ID followed by residue numbers)
This allows users ton fix selected RNA residues during ERRASER. For example, because
protein and ligands are not modeled in ERRASER, we recommand to fix RNA residues 
that interacts strongly with these unmodeled atoms. ERRASER will automatically 
detect residues covalently bonded to removed atoms and hold them fixed during the 
rebuild, but users need to specify residues having non-covalent interaction with 
removed atoms mannually.

-kept_temp_folder
Format: -kept_temp_folder <True/False> / Default: False
Enable this option allows user to examine intermediate output files storing in the 
temp folder. The default is to remove the temp folder after job completion.

Other: 

-rebuild_extra_res
Format/Default: Same as -fixed_res
This allows users to specify extra residues and force ERRASER to rebuild them. 
ERRASER will automatically pick out incorrect residues, but the user may be able 
to find some particular residues that was not fixed after one ERRASER run. The user 
can then re-run ERRASER with -rebuild_extra_res argument, and force ERRASER to 
remodel these residues.

-cutpoint_open
Format/Default: Same as -fixed_res
This allows users to specify cutpoints (where the nucleotide next to it is not 
connected to itself) in the starting model. Since ERRASER will detect cutpoints in 
the model automatically, the users usually do not need to specify this option.

-use_existing_temp_folder
Format: -use_existing_temp_folder <True/False> / Default: True
When is True, ERRASER will use any previous data stored in the existing temp folder 
and skip steps that has been done.Useful when the job stopped abnormally and the 
user try to re-run the same job. Disable it for a fresh run without using previously 
computed data.

-rebuild_all
Format: -rebuild_all <True/False> / Default: False
When is True, ERRASER will rebuild all the residues instead of just rebuilding 
errorenous ones. Residues in "-fixed_res" (see below) are still kept fixed during 
rebuilding. It is more time consuming but not necessary leads to better result. 
Standard rebuilding with more iteration cycles is usually prefered.

-native_screen_RMSD
Format: -native_screen_RMSD <float> / Default: 2.0
In ERRASER default rebuilding, we only samples conformations that are within 2.0 A to 
the starting model (which is the "native" here). The user can modify the RMSD cutoff. 
If the value of native_screen_RMSD is larger than 10.0, the RMSD screening will be turned off.
```

Expected Outputs
================

At the end you will get a output pdb file in standard pdb format. The output file is in the standard PDB format and inherits all the ligands, metals and waters from the input pdb file. You can then further refine the output model directly using PHENIX or other refinement packages without any post-processing.

New things since last release
=============================

* All the application used here (*erraser\_minimizer* , *swa\_rna\_analytical\_closure* and *swa\_rna\_main*) are new as of Rosetta 3.4. A new electron density scoring method `       elec_dens_atomwise      ` is used in ERRASER. ERRASER also uses an updated rna torsional potential based on RNA09 dataset. 
* Recent updates/fixes to the ERRASER code base have been made to address possible bug-related inaccuracies. For best results, all ERRASER users should download/install a weekly build of Rosetta 2015.35 (released Sept. 24, 2015) or later.


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
* [RiboKit](http://ribokit.github.io/): RNA modeling & analysis packages maintained by the Das Lab
