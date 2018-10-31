#Calculate relative binding affinities for RNA-protein complexes 

##Metadata

Author: Kalli Kappel (kappel at stanford dot edu)  
Last updated: April 2018

##Application purpose
The Rosetta-Vienna ΔΔG method is used to calculate relative binding affinities for RNA-protein complexes.  

##Code and demo
All code is located in `src/apps/public/rnp_ddg/`. A demo of the Rosetta-Vienna ΔΔG method is available in `demos/public/rnp_ddg/`. Rosetta-Vienna ΔΔG is also available as a [ROSIE webserver](http://rosie.graylab.jhu.edu/rnp_ddg).  

## The Rosetta-Vienna ΔΔG workflow
1. Relax a starting structure
2. Calculate relative binding affinities for a list of mutants

## Required inputs
1. A starting structure in PDB format.
2. A list of sequences for which to calculate binding affinities relative to the sequence found in the starting structure. This is a text file specifying the sequences for which we want to calculate relative binding affinities. One sequence should be specified per line. These can either be the full sequence of the complex (RNA and protein), or just the RNA sequence. If the protein sequence is not specified, then no mutations to the protein will be made. 

## Running the code

#### Step 1: Set up Rosetta and Vienna code
&nbsp;&nbsp;&nbsp;&nbsp;**1.1**&nbsp;&nbsp;&nbsp;&nbsp;Make sure that you have python (v2.7) installed.  
&nbsp;&nbsp;&nbsp;&nbsp;**1.2**&nbsp;&nbsp;&nbsp;&nbsp;Install Rosetta RNA tools. See instructions and documentation [here](https://www.rosettacommons.org/docs/latest/application_documentation/rna/RNA-tools).  
&nbsp;&nbsp;&nbsp;&nbsp;**1.3**&nbsp;&nbsp;&nbsp;&nbsp;Install the ViennaRNA package. See instructions [here](https://www.tbi.univie.ac.at/RNA/).  

#### Step 2: Relax the starting structure

&nbsp;&nbsp;&nbsp;&nbsp;**2.1**&nbsp;&nbsp;&nbsp;&nbsp;Set up the relaxation run with relax_starting_structure.py. For example, type: 

```
python PATH_TO_ROSETTA/main/source/src/apps/public/rnp_ddg/relax_starting_structure.py --start_struct start_structure.pdb --nstructs 100 --rosetta_prefix PATH_TO_ROSETTA/main/source/bin/
```
  
Inputs and options for `relax_starting_structure.py` are listed below:  <br><br>

**`--start_struct`**: The starting PDB structure of your RNA-protein complex.  
**`--rosetta_prefix`**: The full path to your Rosetta executables (this is optional if the executables are in your PATH).  
**`--sfxn`**: The score function to use for relaxation. **This must be the same score function that will be used to calculate relative binding affinities in Step 3!** *Recommended*: rnp_ddg.wts.  
**`--nstructs`**: Number of times to perform the relaxation. *Recommended*: 100.  

&nbsp;&nbsp;&nbsp;&nbsp;**2.2**&nbsp;&nbsp;&nbsp;&nbsp;Run the relaxation. For example, type:

```
source ALL_RELAX_COMMANDS
```

Alternatively, each of the relaxation commands found in `RELAX_COMMAND_*` can be run separately. This is useful if you’re running on a cluster. 

&nbsp;&nbsp;&nbsp;&nbsp;**2.3**&nbsp;&nbsp;&nbsp;&nbsp;Get the lowest scoring relaxed structures. For example, type:  

```
python PATH_TO_ROSETTA/main/source/src/apps/public/rnp_ddg/get_lowest_scoring_relaxed_models.py --relax_dir relax_start_structure/
```

This will print out the 20 lowest scoring relaxed structures. For best results, the calculations described in *Step 3* should be performed on each one of these structures, and the final ΔΔG results should be averaged over all 20.

#### Step 3: Calculate relative binding affinities

&nbsp;&nbsp;&nbsp;&nbsp;**3.1**&nbsp;&nbsp;&nbsp;&nbsp;Set up the ΔΔG calculations with general_RNP_setup_script.py. This step creates all the necessary directories and files for the ΔΔG calculation runs. For example type:

```
python PATH_TO_ROSETTA/main/source/src/apps/public/rnp_ddg/general_RNP_setup_script.py --low_res --tag demo_run --start_struct relax_start_structure//1/min_again_start_structure_wildtype_bound.pdb --seq_file mutant_list.txt --rosetta_prefix PATH_TO_ROSETTA/main/source/bin/
```

Inputs and options for `general_RNP_setup_script.py` are listed below:  
**`--low_res`**: *(default)* Use the low-res method of calculating RNA-protein relative binding affinities. *This is recommended.* *Should not be specified with --med_res or --high_res.*   
**`--med_res`**: Use `rna_denovo` to build mutant structures when they introduce a non-canonical RNA base pair (i.e. if the WT structure contains a G-C base pair and you specify a mutation to G-G). The low_res protocol will be used for all other mutations.   
**`--high_res`**: Use `stepwise` to build mutant structures. This protocol is much more computationally intensive, and has not yet yielded better results. **This protocol is NOT recommended.**   
**`--skip_RNAfold`**: Do not do the Vienna RNAfold calculations (i.e. assume the folding free energy of all RNA sequences is 0). *This is not recommended.*   
**`--tag`**: Here you can specify a string that will be used to create the name of the output directory.   
**`--overwrite`**: Overwrite the ddG directory if it already exists. If this option is not specified, the directory will not be overwritten (instead a directory ending with e.g. _1 will be created).   
**`--start_struct`**: The starting structure. This should be one of the lowest scoring relaxed structures from *Step 2*.  
**`--wt_secstruct`**: The secondary structure of the RNA in the starting structure. This is only used in the med_res protocol (to determine when we’re mutating from a canonical to a non-canonical RNA base pair). If it is not specified, the secondary structure will be predicted with RNAfold.   
**`--seq_file`**: This is a text file specifying the sequences for which we want to calculate relative binding affinities. One sequence should be specified per line. These can either be the full sequence of the complex (RNA and protein), or just the RNA sequence. If the protein sequence is not specified, then no mutations to the protein will be made.   
**`--sfxn`**: The Rosetta score function to use. *Recommended (default): rnp_ddg.wts.* *This should be the same score function that you used during relaxation in Step 2!*   
**`--rosetta_prefix`**: The full path to your Rosetta executables (this is optional if the executables are in your PATH).   
**`--relax_cutoff_dist`**: Relax cutoff distance (from a mutation) for sidechain repacking. *Recommended (default): 20.0*   
**`--protein_pack_reps`**: The number of times the "unbound" protein structure should be repacked, to calculate the energy of the unbound protein. *Recommended (default): 10*   
**`--Nreps`**: The number of times the mutation and subsequent relaxation of surrounding residues should be performed. *Recommended (default): 10*   
**`--no_min_jumps`**: Do not minimize the rigid body orientations. *Not recommended.*   
**`--move_backbone`**: Move the backbone during minimization. *Not recommended.*   
**`--move_protein_backbone`**: Move the protein backbone during minimization. *Not recommended.*  

This setup command will create a directory named e.g. `ddG_demo_run_low-res`. In this directory, there is a numbered subdirectory corresponding to each of the mutant sequences that were specified in the `mutant_list.txt` file. `0/` corresponds to the wildtype, `1/` corresponds to the first sequence listed in `mutant_list.txt`, `2/` corresponds to the second sequence listed in `mutant_list.txt`, etc. 

`ddG_demo_run_low/general_setup_settings.txt` lists the options that will be used for the run.   `ddG_demo_run_low/ALL_COMMANDS` contains the actual command lines to run all of the ΔΔG calculations.  `ddG_demo_run_low/COMMAND_0`, `ddG_demo_run_low/COMMAND_1`, and `ddG_demo_run_low/COMMAND_2` contain the commands to run the ΔΔG calculations for the wildtype, first, and second mutations, respectively. All of these commands are contained within `ddG_demo_run_low/ALL_COMMANDS`; these individual files are just useful if you're running a lot of mutants on a cluster -- each command can be run simultaneously on a different core.   

&nbsp;&nbsp;&nbsp;&nbsp;**3.2**&nbsp;&nbsp;&nbsp;&nbsp; Run the ΔΔG calculations. For example, type:

```
source ddG_demo_run_low-res/ALL_COMMANDS
```

Alternatively, each of the commands found in `ddG_demo_run_low-res/COMMAND_*` can be run separately. This is useful if you’re running on a cluster.  

&nbsp;&nbsp;&nbsp;&nbsp;**3.3**&nbsp;&nbsp;&nbsp;&nbsp; Get the ΔΔG results with `get_final_ddG_scores.py`. For example, type: 

```
python PATH_TO_ROSETTA/main/source/src/apps/public/rnp_ddg/get_final_ddG_scores.py --run_dir ddG_demo_run_low-res/ --seq_file mutant_list.txt
```

**`--run_dir`** should specify the directory that the ΔΔG calculations were run in (the one that was created by `general_RNP_setup_script.py`). **`--seq_file`** should list the same `seq_file` that was provided to `general_RNP_setup_script.py`.   

This will print a message like the following to the screen:  

```
####################################
RESULTS:

WT ddG: 0.00 kcal/mol
ugaggcucaccca ddG: 2.39 kcal/mol
ugaggagcaccca ddG: 0.62 kcal/mol

####################################
Results are also written to the ddG_score.txt files in
each mutant directory in ddG_demo_run_low-res/
The format is:
ddG dG complex_score protein_score rna_score
####################################
```

As noted in this message, the ΔΔG results are also listed in the `ddG_score.txt` files in each of the run directories. The first column in a `ddG_score.txt` specifies the calculated ΔΔG value in kcal/mol.

Normally, *Step 3* should be repeated 20 times for the top 20 structures from *Step 2*, and then the final results should be averaged.  

##See Also

* [[Application Documentation]]: Home page for application documentation
* [[RNA applications]]: The RNA applications home page
* [[Tools]]: Python-based tools for use in Rosetta
* [RiboKit](http://ribokit.github.io/): RNA modeling & analysis packages maintained by the Das Lab