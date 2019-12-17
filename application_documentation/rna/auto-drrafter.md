#auto-DRRAFTER: Automatically model RNA coordinates into cryo-EM maps

##Metadata

Author: Kalli Kappel (kappel at stanford dot edu)  
Last updated: December 2019

##Application purpose

auto-DRRAFTER is used to build RNA coordinates into cryo-EM maps. Unlike DRRAFTER, it does not require initial manual helix placement. Currently, auto-DRRAFTER works only for systems that only RNA.

##Reference
auto-DRRAFTER is described in [this paper](https://www.biorxiv.org/content/10.1101/717801v1):  
Kappel, K.\*, Zhang, K.\*, Su, Z.\*, Kladwang, W., Li, S., Pintilie, G., Topkar, V.V., Rangan, R., Zheludev, I.N., Watkins, A.M., Yesselman, J.D., Chiu, W., Das, R. (2019). Ribosolve: Rapid determination of three-dimensional RNA-only structures. bioRxiv.

##Code and demo
auto-DRRAFTER code will be available in the Rosetta weekly releases after 2019.47 (it is not available in 2019.47). **auto-DRRAFTER is NOT available in Rosetta 3.11**.

All of the auto-DRRAFTER scripts are located in `ROSETTA_HOME/demos/public/DRRAFTER/`.

##Setting up auto-DRRAFTER
  
1. Download Rosetta here <https://www.rosettacommons.org/software/license-and-download>. You will need to get a license before downloading Rosetta (free for academic users). auto-DRRAFTER will be available starting in Rosetta weekly releases *after* 2019.47. **auto-DRRAFTER is NOT available in Rosetta 3.11 (it will be available in 3.12)**.  
2. If you're not using the precompiled binaries (these are available for Mac and Linux and you can access them by downloading source+binaries in Step 1), install Rosetta following the instructions available [here] (https://www.rosettacommons.org/docs/latest/build_documentation/Build-Documentation).  
3. Make sure you have python installed and install networkx and mrcfile. For example, type: pip install networkx mrcfile
4. Install EMAN2 version 2.22 (https://blake.bcm.edu/emanwiki/EMAN2/Install). Confirm that e2proc3d.py and e2segment3d.py are installed by typing:   
`e2proc3d.py –h`
`e2segment3d.py –h` 
You should see usage instructions for each of these commands.  
5. Install Rosetta RNA tools. See instructions and documentation [here] (https://www.rosettacommons.org/docs/latest/application_documentation/rna/RNA-tools).  
6. Check that the ROSETTA environmental variable is set (you should have set this up during RNA tools installation). Type echo $ROSETTA. This should return the path to your Rosetta directory. If it does not return anything, go back to step 5 and make sure that you follow the steps for RNA tools setup.  
7. Add the path to the auto-DRRAFTER scripts to your $PATH (alternatively, you can type the full path to the scripts each time that you use them). They are found in main/source/src/apps/public/DRRAFTER/ in your Rosetta directory. An example for bash:  
`export PATH=$PATH:$ROSETTA/main/source/src/apps/public/DRRAFTER/`  

##Required input files
The following input files are required:  
`fasta.txt`: The FASTA file listing the full sequence of your RNA molecule. It should contain one line that starts with '>' and lists the chain and residue numbers for the sequence, e.g. A:1-35. *Currently auto-DRRAFTER can only handle single chain RNAs.*  
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
**Step 1**: Low-pass filter the density map and determine the threshold level.  
`python $ROSETTA/main/source/src/apps/public/DRRAFTER/auto-DRRAFTER_setup.py -map_thr 30 -full_dens_map input_files/map.mrc -full_dens_map_reso 10.0 -fasta input_files/fasta.txt -secstruct input_files/secstruct.txt -out_pref mini_example -rosetta_directory $ROSETTA/main/source/bin/ -nstruct_per_job 10 -cycles 1000 -fit_only_one_helix –just_low_pass`  

`-map_thr` is the density threshold at which the detection of optimal helix placement locations will take place. This is the value that we’re trying to figure out in this step, so the actual number that we put here doesn’t matter yet.   
`-full_dens_map` is our density map.   
`-full_dens_map_res` is the resolution of the density map in Å.  
`-fasta` is the fasta file listing the sequence of our RNA molecule.  
`-secstruct` is the secondary structure of the RNA molecule in dot-bracket notation.  
`-out_pref` is the prefix for output files generated by auto-DRRAFTER (we will use `mini_example` for the remainder of the instructions).  
`-rosetta_directory` is the location of the Rosetta executables.  
`-repeats` is the number of independent attempts to place the helices. 10 is usually a good number for this setting.  

This will create a single file: `mini_example_lp20.mrc`. This is the low-pass filtered density map, which will be used to figure out the initial helix placements.

**Step 2**: Open the low-pass filtered density map (`mini_example_lp20.mrc`) in Chimera. Change the threshold of the density map (using the sliding bar on the density histogram). You want to find the highest threshold such that you can clearly discern "end nodes" in the density map, but also such that the density map is still fully connected. Note that this threshold is only used for the initial helix placement and does not have any affect on the later modeling steps.  

**Step 3**: Set up the auto-DRRAFTER run by typing:  
`python $ROSETTA/main/source/src/apps/public/DRRAFTER/auto-DRRAFTER_setup.py -map_thr 30 -full_dens_map input_files/map.mrc -full_dens_map_reso 10.0 -fasta input_files/fasta.txt -secstruct input_files/secstruct.txt -out_pref mini_example -rosetta_directory $ROSETTA/main/source/bin/ -nstruct_per_job 10 -cycles 1000 -fit_only_one_helix`  

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

