#auto-DRRAFTER: Automatically model RNA coordinates into cryo-EM maps

##Metadata

Author: Kalli Kappel (kkappel at alumni dot stanford dot edu)  
Last updated: March 2020

##Application purpose

auto-DRRAFTER is used to build RNA coordinates into cryo-EM maps. Unlike DRRAFTER, it does not require initial manual helix placement. Currently, auto-DRRAFTER works only for systems that only contain RNA.

##Reference
auto-DRRAFTER is described in [this paper](https://www.biorxiv.org/content/10.1101/717801v1):  
Kappel, K.\*, Zhang, K.\*, Su, Z.\*, Kladwang, W., Li, S., Pintilie, G., Topkar, V.V., Rangan, R., Zheludev, I.N., Watkins, A.M., Yesselman, J.D., Chiu, W., Das, R. (2019). Ribosolve: Rapid determination of three-dimensional RNA-only structures. bioRxiv.

##Code and demo
auto-DRRAFTER code will be available in the Rosetta weekly releases after 2019.47 (it is not available in 2019.47). **auto-DRRAFTER is NOT available in Rosetta 3.11**.

All of the auto-DRRAFTER scripts are located in `ROSETTA_HOME/main/src/apps/public/DRRAFTER/`.

A demo of auto-DRRAFTER is available in `ROSETTA_HOME/main/demos/public/drrafter/` (available in releases after 2020.03). Instructions for the demo can be found [here](https://www.rosettacommons.org/demos/latest/public/auto-drrafter/README). ***It is highly recommended to go through the full demo AND read through all the documentation on this page before trying to run auto-DRRAFTER for your RNA.***

##On this page:
[Setting up auto-DRRAFTER](#setting-up-auto-DRRAFTER): Do this before running auto-DRRAFTER.   
[Required input files](#required-input-files): This describes the input files you'll need to prepare.   
[Running auto-DRRAFTER](#running-auto-drrafter): This describes the steps for running auto-DRRAFTER.   
[Manually setting up an auto-DRRAFTER run](#manually-setting-up-an-auto-drrafter-run): This is useful if you know something about your RNA structure (like where a piece of the structure sits in the density map) and/or want to run auto-DRRAFTER through the ROSIE server.   

##Setting up auto-DRRAFTER
  
1. Download Rosetta here <https://www.rosettacommons.org/software/license-and-download>. You will need to get a license before downloading Rosetta (free for academic users). auto-DRRAFTER will be available starting in Rosetta weekly releases *after* 2019.47. **auto-DRRAFTER is NOT available in Rosetta 3.11 (it will be available in 3.12)**.  
2. If you're not using the precompiled binaries (these are available for Mac and Linux and you can access them by downloading source+binaries in Step 1), install Rosetta following the instructions available [here] (https://www.rosettacommons.org/docs/latest/build_documentation/Build-Documentation).  
3. Make sure you have python installed and install networkx and mrcfile. For example, type: `pip install networkx mrcfile`
4. Install EMAN2 version 2.22 (https://blake.bcm.edu/emanwiki/EMAN2/Install). Confirm that `e2proc3d.py` and `e2segment3d.py` are installed by typing:   
```
e2proc3d.py –h
```
```
e2segment3d.py –h
``` 
You should see usage instructions for each of these commands.  
5. Install Rosetta RNA tools. See instructions and documentation [here] (https://www.rosettacommons.org/docs/latest/application_documentation/rna/RNA-tools).  
6. Check that the ROSETTA environmental variable is set (you should have set this up during RNA tools installation). Type echo $ROSETTA. This should return the path to your Rosetta directory. If it does not return anything, go back to step 5 and make sure that you follow the steps for RNA tools setup.  
7. Add the path to the auto-DRRAFTER scripts to your $PATH (alternatively, you can type the full path to the scripts each time that you use them). They are found in main/source/src/apps/public/DRRAFTER/ in your Rosetta directory. An example for bash:  
```
export PATH=$PATH:$ROSETTA/main/source/src/apps/public/DRRAFTER/
```  

##Required input files
The following input files are required:  
`fasta.txt`: The FASTA file listing the full sequence of your RNA molecule. It should contain one line that starts with '>' and lists the chain and residue numbers for the sequence, e.g. A:1-35. The RNA sequence should be specified with lower-case letters. *Currently auto-DRRAFTER can only handle single chain RNAs.*  
`secstruct.txt`: A file containing the secondary structure of the complex in dot-bracket notation. The secondary structure should be the same length as the sequence found in the fasta file. This secondary structure will be enforced during the auto-DRRAFTER modeling. We recommend verifying predicted secondary structures biochemically with [M2-seq](https://doi.org/10.1073/pnas.1619897114).  
`map.mrc`: The density map file in mrc format.  
`job_submission_template.sh`: This should be a job submission script for the cluster you’re planning to run your job on. For example, it might look something like this:   
```
#!/bin/bash
#SBATCH -J JOB_NAME
#SBATCH -o /dev/null
#SBATCH -e /dev/null
#SBATCH -p owners
#SBATCH -t 48:00:00
#SBATCH -n 1
#SBATCH -N 1
```
Alternatively, the `job_submission_template.sh` may just be a blank file if you are planning to run the job on your laptop. Typical auto-DRRAFTER jobs cannot be run on a laptop.  


##Running auto-DRRAFTER
The auto-DRRAFTER workflow is described below.  
####**Step 1**: Low-pass filter the density map and determine the threshold level.  
```
python $ROSETTA/main/source/src/apps/public/DRRAFTER/auto-DRRAFTER_setup.py -map_thr 30 -full_dens_map input_files/map.mrc -full_dens_map_reso 10.0 -fasta input_files/fasta.txt -secstruct input_files/secstruct.txt -out_pref mini_example -rosetta_directory $ROSETTA/main/source/bin/ -nstruct_per_job 100 -cycles 1000 -fit_only_one_helix -rosetta_extension .static.linuxgccrelease -just_low_pass
```  

`-map_thr` is the density threshold at which the detection of optimal helix placement locations will take place. This is the value that we’re trying to figure out in this step, so the actual number that we put here doesn’t matter yet.   
`-full_dens_map` is our density map.   
`-full_dens_map_res` is the resolution of the density map in Å.  
`-fasta` is the fasta file listing the sequence of our RNA molecule.  
`-secstruct` is the secondary structure of the RNA molecule in dot-bracket notation.  
`-out_pref` is the prefix for output files generated by auto-DRRAFTER (we will use `mini_example` for the remainder of the instructions).  
`-rosetta_directory` is the location of the Rosetta executables.  
`-rosetta_extension` is the extension of your Rosetta executables.  
`-repeats` is the number of independent attempts to place the helices. 10 is usually a good number for this setting.  

This will create a single file: `mini_example_lp20.mrc`. This is the low-pass filtered density map, which will be used to figure out the initial helix placements.

####**Step 2**: Open the low-pass filtered density map (`mini_example_lp20.mrc`) in Chimera.   
Change the threshold of the density map (using the sliding bar on the density histogram). You want to find the highest threshold such that you can clearly discern "end nodes" in the density map, but also such that the density map is still fully connected. Note that this threshold is only used for the initial helix placement and does not have any affect on the later modeling steps.  

####**Step 3**: Set up the auto-DRRAFTER run.   
Type:  
```
python $ROSETTA/main/source/src/apps/public/DRRAFTER/auto-DRRAFTER_setup.py -map_thr 30 -full_dens_map input_files/map.mrc -full_dens_map_reso 10.0 -fasta input_files/fasta.txt -secstruct input_files/secstruct.txt -out_pref mini_example -rosetta_directory $ROSETTA/main/source/bin/ -nstruct_per_job 100 -cycles 1000 -fit_only_one_helix -rosetta_extension .static.linuxgccrelease
```  

This is the same command that we used in step 1, except we have removed the `–just_low_pass` flag and the value for `-map_thr` should be updated with the value that you determined in step 2. Depending on the helix placements that come out, you may want to change the threshold again.   

This will print a message that looks something like this:  

```
Low-pass filtering the map to 20A.
Converting density map to graph.
Possible end nodes in the map: 
3 4 
You can visualize the end nodes in mini_example_init_points.pdb
You can specify which of these end nodes you'd like to use with -use_end_node
Converting secondary structure to graph.
Mapping secondary structure to density map.
Setting up DRRAFTER runs.
Making full helix H0
Making full helix H1
```

It's generally a good idea to open up `mini_example_init_points.pdb` and your density map in PyMol or Chimera and check that the possible end nodes listed in this message actually make sense (here `3` and `4`, which you can identify as residue numbers 3 and 4 in `mini_example_init_points.pdb`). If you really like one of these end node positions, you might want to specify that it should be used explicitly. For example, if we really liked end node `3`, then we could specify that we should use this end node by re-running the command above and adding the flag `–use_end_node 3`.   

Auto-DRRAFTER then converts the RNA secondary structure (that we specified) to a graph in which helices are represented as edges and junctions and loops are represented as nodes. This secondary structure graph is then mapped onto the graph for the density map.   
Auto-DRRAFTER then sets up the DRRAFTER runs for each of these mappings. This involves building ideal A-form helices for all helical regions of the secondary structure, adding placeholder coordinates for all the hairpins onto these ideal RNA helices, and creating all the specific input files that DRRAFTER requires.   
**`auto-DRRFTER_setup.py` will create the following files**:  

`settings_mini_example.txt`: This file lists all of the settings that were used to set up this auto-DRRAFTER run.  

`all_aligned_mini_example_*.REORDER.pdb`: These are the possible helix placements in the density map. Each model will be used in a separate DRRAFTER run.  

`command_mini_example_*_R1`: The commands for the DRRAFTER runs for the possible alignments of the helices into the density map.  

`fasta_mini_example.txt`: The fasta file for the DRRAFTER runs. This is basically the same as the input fasta file, but the numbering has been changed to start at 0 – this is just an auto-DRRAFTER convention. A final step at the end of the auto-DRRAFTER modeling will map these residues numbers back to the input residue numbers.    

`flags_mini_example_*_R1`: These files contain all the flags that will be used for the two DRRAFTER runs for the different helix alignments in the density map.

`mini_example_H*.pdb`: Ideal A-form helices.   

`mini_example_H*_full.out.1.pdb`: The same idea A-form helices from above with placeholder coordinates added for the hairpins.   

`mini_example_auto_fits.txt`: This file lists all of the different possible alignments of helices into the density map. Each alignment is numbered and listed on a separate line in this file.   

`mini_example_init_points.pdb`: This PDB file contains all of the points that were placed into the density map in order to convert the density map into a graph.   

`secstruct_mini_example.txt`: The secondary structure file for the DRRAFTER runs.

####**Step 4**: Submit/run the DRRAFTER jobs.   
Type:  
```
python $ROSETTA/main/source/src/apps/public/DRRAFTER/submit_jobs.py -out_pref mini_example -curr_round R1 -njobs 25 -template_submission_script input_files/job_submission_template.sh -queue_command source
```  

`-out_pref` is the prefix used for all output files from this run, this should be the same –out_pref that was used in the setup commands.   
`-curr_round`: This is the round of modeling that is currently being performed. We haven’t done any modeling yet, so this is round 1. This should always be ‘R’ followed by a number that indicates the round number.   
`-njobs`: This is the number of jobs that will be run. Each job will build the number of models that was specified in the setup command above (-nstruct_per_job), in this case 10 structures per job. We will therefore build 20 models in total (10 structures per job x 2 jobs).
`-template_submission_script`: This should be a job submission script for the cluster you’re planning to run your job on. Here, we’re not running this on a cluster (this demo can be run on a laptop), so the job submission script is just a blank file.   
`-queue_command`: This is the command that will be used to submit the job files to a cluster queuing system. If you want to run locally you can use the use "source". Alternatively, this might be something like `sbatch` or `qsub`, depending on the cluster that you’re using.   

This command will take several hours (typically 12-24), depending on the number of models built per job (and of course, how quickly your jobs will be run on the cluster that you’re using).   

This will create the following output files:   

`job_files/`: This is a directory that contains all the job submission files.
`out_mini_example_*_R1/`: These directories contains all the DRRAFTER models built for each helix alignment.   

####**Step 5**: Set up the next round of modeling.

```
python $ROSETTA/main/source/src/apps/public/DRRAFTER/auto-DRRAFTER_setup_next_round.py -out_pref mini_example -curr_round R1 -rosetta_directory $ROSETTA/main/source/bin/ -rosetta_extension .static.linuxgccrelease
```  

This will print something like this to the screen:  

```
Setting up next round
Overall convergence 0.373
Density threshold: 38.779
```  

This step collects all of the models from the previous step and calculates the convergence of the overall top ten scoring models (across all alignments). That is the "Overall convergence" value that is printed out. Then the next round of modeling is set up based on the models that were built from the previous round. Regions of the models that are well converged will be kept fixed in the next round of modeling.  

Several files are written out at this step. The key files that you want to know about are:

`mini_example_all_models_all_fits_R1.out.*.pdb`: These are the overall best scoring models from all of the different alignments from the first round of modeling. 

`command_mini_example_*_R2`: These are the command file for the next round of modeling. The file names will indicate the next round of modeling that should be performed (in this case `R2`, but if the output files had been `command_mini_example_*_FINAL_R2`, then the next round would instead be `FINAL_R2`.)  

`flags_mini_example_*_R2`: These files contain all the flags that will be used for the two DRRAFTER runs for the different helix alignments in the density map.   

`all_fit_mini_example_*_R2.REORDER.pdb`: These PDB files contain initial helix placements for the next round of modeling.  

`convergence_mini_example_all_models_R1.txt`: This file lists the convergence for the overall top scoring models.   

Generally less important files, but good to know about for debugging:   

`mini_example_*_R1_CAT_ALL_ROUNDS.out.*.pdb`: These are the top scoring models from each of the initial helix placements.   
  

**The "Density threshold" (printed to the screen when you run this step) is very important.** This is the value that is used to determine whether regions of the RNA that are well converged will actually be kept fixed during the next round of modeling. The value that is printed to the screen is the value that was determined automatically. Sometimes, particularly for higher-resolution maps (better than about ~6 Å resolution) or for maps that are relatively noisy, this automatically selected value is too high. This can make it so that regions that are well converged and do fit reasonably well in the density map are not kept fixed in subsequent rounds of modeling, making it much more challenging for the models to converge overall. You can check whether this might be a problem in your case by examining the top scoring models from each fit from the last round (`mini_example_*_R1_CAT_ALL_ROUNDS.out.*.pdb`) as well as the PDB files containing the regions that will be kept fixed for the subsequent round of modeling (`all_fit_mini_example_*_R2.REORDER.pdb`). If there are regions of your models that look pretty well converged, but do not show up in the `all_fit_mini_example_*_R2.REORDER.pdb` files, then you might want to re-run this step and use the flag `-dens_thr` to select a lower value for the density threshold. It often makes sense to try reducing the density threshold by ~50% (so if the density threshold was automatically selected to be 38.779 as shown above, then try `-dens_thr 19` when you re-run the `auto-DRRAFTER_setup_next_round.py` the first time). If you still see a similar problem, you can reduce the density threshold even further.    


####Steps 4 and 5 should then be iterated. 
`-curr_round` must be updated each time, until the modeling is complete (there must be two successive round of `FINAL` modeling, e.g. `FINAL_R2` then `FINAL_R3`).


####**Final step**: Finalize the models.  
Type:   
```
python $ROSETTA/main/source/src/apps/public/DRRAFTER/finalize_models.py -fasta input_files/fasta.txt -out_pref mini_example -final_round FINAL_R6
```  
`-fasta` is the fasta that was used to set up the run in step 1.
`-out_pref` is the same –out_pref that was used to set up the run in step 1
`-final_round` is the last round of modeling that was just completed (something like `FINAL_R6`).   

This should print `Done finalizing models` to the screen, indicating that the modeling is complete. This creates the final models: `mini_example_all_models_all_fits_FINAL_R6.out.*.pdb`. These models should be carefully inspected in the context of the density map.

##Manually setting up an auto-DRRAFTER run
Sometimes you might know where a piece of your RNA structure should sit within your density map. If that's the case, you might want to actually use that information during auto-DRRAFTER modeling. This section describes how you can do that.  

###Creating input files
This section would replace steps 1-3 of the pipeline above. We need to create the following seven sets of files:

1. `helix_fit_in_map.pdb`: This PDB file should contain a piece of the RNA structure fit into the density map. Numbering must match that found in your fasta file (see below).  

2. `fasta_mini_example.txt`: The fasta file for the DRRAFTER runs. Numbering should start from 0 and must match the numbering in all PDB files. All RNA residues should be denoted with lower-case letters (`a`,`c`,`g`,`u`).       

3. `secstruct_mini_example.txt`: The secondary structure file for the DRRAFTER runs in dot-bracket notation. The length of the secondary structure should exactly match the length of the sequence in your fasta file.   

4. `flags_mini_example_R1`: This file contains all the flags that will be used for the DRRAFTER run. **It's very important to set this file up properly. Please read carefully through the example below.**   
                                         
    ```
    -fasta <fasta_mini_example.txt>
    -secstruct_file <secstruct_mini_example.txt>
    -s <helix_fit_in_map.pdb> <helix_1.pdb helix_2.pdb helix_3.pdb ...>
    -edensity:mapfile <input_files/map.mrc>
    -edensity:mapreso <10.0>
    -out:file:silent <mini_example_R1.out>
    -cycles <30000>
    -dock_into_density <false>
    -nstruct <100>
    -new_fold_tree_initializer true
    -ft_close_chains false
    -bps_moves false
    -minimize_rna true
    -minimize_protein_sc true
    -rna_protein_docking true
    -rnp_min_first true
    -rnp_pack_first true
    -rnp_high_res_cycles 2
    -minimize_rounds 1
    -ignore_zero_occupancy false
    -convert_protein_CEN false
    -FA_low_res_rnp_scoring true
    -ramp_rnp_vdw true
    -docking_move_size 0.5 
    -dock_each_chunk_per_chain false
    -mute protocols.moves.RigidBodyMover
    -mute protocols.rna.denovo.movers.RNA_HelixMover
    -use_legacy_job_distributor true
    -no_filters
    -set_weights linear_chainbreak 20.0
    -jump_library_file RNA18_HUB_2.154_2.5.jump 
    -vall_torsions RNA18_HUB_2.154_2.5.torsions
    -score:weights stepwise/rna/rna_res_level_energy4.wts 
    -restore_talaris_behavior
    -edensity:cryoem_scatterers
    ```

    The most important options that you will need to modify are:  
    * **`-fasta <fasta_mini_example.txt>`**: You should replace `fasta_mini_example.txt` with your fasta file.  
    * **`-secstruct_file <secstruct_mini_example.txt>`**: You should replace `secstruct_mini_example.txt` with your secondary structure file.  
    * **`-s <helix_fit_in_map.pdb> <helix_1.pdb helix_2.pdb helix_3.pdb ...>`**: These are all of the pieces of the RNA structure for which you have PDB files. Importantly, you should have a separate PDB file for each of the RNA helices in your structure. You'll need to create these using `rna_helix.py` (see instructions [here](https://www.rosettacommons.org/docs/wiki/application_documentation/rna/RNA-tools#some-useful-tools_rna-modeling-utilities); make sure that you have [RNA tools set up first](https://www.rosettacommons.org/docs/wiki/application_documentation/rna/RNA-tools#setup)). **The order of these files is important!** The PDB file that has been fit into your density map must be listed first. All other helices should follow (these don't need to be fit into the density map — auto-DRRAFTER will actually ignore the relative placement of all but the first listed PDB file).  
    * **`-edensity:mapfile <input_files/map.mrc>`**: Replace `input_files/map.mrc` with your density map file.  
    * **`-edensity:mapreso <10.0>`**: Replace `10.0` with the resolution of your density map.  
    * **`-out:file:silent <mini_example>_R1.out`**: Replace `mini_example` with your desired prefix for the output file. This should match the name in your fasta and secondary structure files (e.g. fasta_**mini_example**.txt, secstruct_**mini_example**.txt, and **mini_example**_R1.out).  
    * **`-cycles <30000>`**: Replace 1000 with the number of Monte Carlo cycles that you would like per structure. `30000` is generally a good number.   
    * **`-dock_into_density <false>`**: This option controls whether the RNA structure that you fit into the density map will be allowed to move within the density map during the run. If you are very confident in the placement, then this option should be set to `false`. If you're less certain, then you can set it to `true`.  
    * **`-nstruct <100>`**: Replace 100 with the number of structures that you'd like to build per job, per round of modeling. (This is different than the number of structure that you want to build per round. For example, if you run 10 jobs, each with `-nstruct 100`, then you will have 10x100=1000 models for that round.)   
You should not need to change any of the other flags in this file.  
        
5. `command_mini_example_R1`: The commands for the DRRAFTER runs for the possible alignments of the helices into the density map. For example:   
```
$ROSETTA/main/source/bin/rna_denovo @flags_mini_example_R1
```

6. `helix_1.pdb`, `helix_2.pdb`, etc.: Ideal A-form helices for all helical regions of your RNA. These are all the files listed in the `-s` option in your `flags` file (see above). You'll need to create these using `rna_helix.py` (see instructions [here](https://www.rosettacommons.org/docs/wiki/application_documentation/rna/RNA-tools#some-useful-tools_rna-modeling-utilities); make sure that you have [RNA tools set up first](https://www.rosettacommons.org/docs/wiki/application_documentation/rna/RNA-tools#setup)).     

7. `mini_example_auto_fits.txt`: This file should contain a single line that reads:
```
SINGLE_FIT
```
This denotes that the run has been set up manually and that there is only a single possible placement of the RNA within the density map (as opposed to the many possible alignments that `auto-DRRAFTER_setup.py` would create).   

8. `job_submission_template.sh`: This file is described [above](#required-input-files).

###An important note about the files above
The other important thing to note is that the names of all of the above files are important. Each time that "mini_example" appears in one of the file names above, this should be replaced with the `-out_pref` that you are planning to use for subsequent steps of the auto-DRRAFTER modeling pipeline.  

###Proceeding to run auto-DRRAFTER
After setting up these files, you can proceed to step 4 of the "Running auto-DRRAFTER" instructions [above](#running-auto-drrafter).