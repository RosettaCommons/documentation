#Antibody Design Analysis

![ ](https://github.com/RosettaCommons/documentation/blob/master/images/antibody_design_strat_analysis_main.png?raw=true)

Antibody design analysis consists of two parts: <code>analyze_antibody_design_strategy.py</code> and <code>compare_antibody_design_strategies.py</code>

These will eventually be moved to Rosetta/tools/antibody/analysis

##Setup

Requirements include:
- PyRosetta
- Biopython
- Compiled Rosetta
- Rosetta Tools
- Clustal Omega

A basic understanding of how to edit your shell profile (if using zsh, this can be edited via $HOME/.zshrc.  If you are using Bash on linux, the profile is at $HOME/.bashrc if mac, then $HOME/.bash_profile.  Remember, no spaces before or after any equal signs.  More information on this can be found throughout the web.  [http://docs.oracle.com/cd/E19683-01/806-7612/6jgfmsvrq/index.html](this) for example.

### PyRosetta Setup
Download PyRosetta from [www.pyrosetta.org](here) or compile it from C++ Rosetta.
Add the PyRosetta directory to your path by either running SetPyRosettaEnvironment.sh or by adding this to your bashrc/zshrc or whatever shell profile you are using so that SetPyRosettaEnvironment is run every time you open a new shell (source path/to/SetPyRosettaEnvironment.sh). This is preferred.  This will enable import of PyRosetta and associated PyRosetta Toolkit modules located in pyrosetta/apps/pyrosetta_toolkit.

### BioPython Setup
Biopython is used to load structures quicker then PyRosetta to output combined FASTA files for running Clustal Omega.  PyRosetta is great, but memory and speed are important when you have hundreds or thousands of structures.  

To install Biopython, run <code>setup_biopython.sh</code> located in the directory containing the analysis scripts

### Rosetta Setup
Rosetta should be compiled.  Rosetta will be used to run the FeaturesReporters through RosettaScripts.  The Rosetta/main/bin directory should be added to your path in your shell profile, and you should set the Rosetta database.  This will make it so that you do not need to give the database path while running Rosetta.  <code>export ROSETTA3_DB=path/to/Rosetta/main/database</code>

### Rosetta Tools
The Rosetta Tools repository should be [https://github.com/RosettaCommons/tools](cloned)
The path to this repository should be added to your pthonpath in your shell profile. For example, I add this line to my zshrc file: <code>export PYTHONPATH=$PYTHONPATH:/Users/jadolfbr/Documents/modeling/rosetta/Rosetta/tools</code>  You will need to checkout the antibody_tools branch until I merge this into git. 

### Clustal Omega
The last thing you need to run all this is clustal Omega.  This is to create alignments between you top designs, and between your strategies.   See [http://www.clustal.org/omega/](this page) for download instructions.  The clustal binary executable should be renamed clustal_omega, and the directory in which it resides should be added to your path, for example: <code>export PATH=$PATH:/Users/jadolfbr/Documents/modeling/bin</code>

## Analyzing Antibody Design Strategies
This script, <code>analyze_antibody_design_strategy.py</code> analyzes one strategy at a time.  You should run it from the directory it is in.  Use <code>./analyze_antibody_design_strategy.py --help</code> to get an idea of the options available.  Generally, it should only presently be used for the creation of the FeaturesReporter databases. These will have an analysis of DGs, energies, hbonds, cdr lengths, etc for each PDB in the strategy.  It is useful to run the code via a shell script for all the strategies you have available, as these can be backgrounded to analyze multiple strategy runs simultaneously. 

### Required Options:
#### Input
Input can either be a txt file with a list of PDBs, or a directory of PDBs. 

- <code> --PDBLIST path/to/pdblist </code>
- - This PDBLIST can either have full or relative paths to the PDBs.  If relative, then the next option should be set

- <code> --indir path/to/pdbs </code> 
- - This Should be set if you want to parse a single directory (non-recursively) or you have relative paths in your PDBLIST

- <code> --rosetta_extension linuxclangrelease for example </code>
- -  This is the Rosetta extension that will be used to call RosettaScripts to create the features databases.  Generally, it is in this format: system - compiler - mode.  System for mac is macos.  Default for compiler is gcc, but may be clang on mac systems.  Release is much quicker then debug mode.  Why debug mode is the default mode is beyond me. 


### Output
- <code> --outdir </code>
- - The relative or full output directory.  If not created, will create it.

- <code> --out_name </code>
- - The output name of the resultant database.  

- <code> --out_db_batch </code>
- - The batch name of the experiment that will go into the resultant database.

- <code> --score_weights talaris2013 </code>
- - Optionally set a weights file to use when adding scoring features or rescoring. If you have a patch, you will need to create a full weights file instead and put it in the rosetta database.  


### Analysis Options
You can run all analysis by passing the <code> --do_all </code> option, however, this is not recommend as rescoring via PyRosetta takes a very long time.  We will use the scores generated and output into the features database, as well as output tops, write pymol sessions, etc. during our comparison.  It is recommended to run the antibody_features reporters on all of your models, but you can run them on only top scoring.  See -help for more scoring options.  This is not recommended, as you will need to rescore all the models before the run. 


Recommended:

- <code> --do_run_antibody_features_all </code>
 - Pass to enable.  Run the AntibodyFeatures to create databases for the strategy on all PDBs

Not Recommended:

- <code> --do_run_antibody_features_top </code>
- - Pass to enable.    Run the AntibodyFeatures to create databases for the strategy on the top x PDBs.  If not rescored, will rescore.

- <code> --do_run_cluster_features_all </code>
- - Pass to enable. Run only the ClusterFeatures reporter on all PDBs in list or directory

- <code> --do_run_cluster_features_top </code>
- - Pass to enable. Run the ClusterFeatures reporter on the top x PDBs of the strategy.  Rescore PDB list if necessary.


## Comparing Antibody Design Strategies

### File
![ ](https://github.com/RosettaCommons/documentation/blob/master/images/antibody_design_strat_analysis_file.png?raw=true)

### Score
![ ](https://github.com/RosettaCommons/documentation/blob/master/images/antibody_design_strat_analysis_score.png?raw=true)

### Clustal
![ ](https://github.com/RosettaCommons/documentation/blob/master/images/antibody_design_strat_analysis_clustal.png?raw=true)

### Enrichments
![ ](https://github.com/RosettaCommons/documentation/blob/master/images/antibody_design_strat_analysis_enrichments.png?raw=true)

### Filters
