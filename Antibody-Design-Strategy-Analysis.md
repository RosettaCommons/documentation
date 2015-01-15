#Antibody Design Analysis

![ ](https://github.com/RosettaCommons/documentation/blob/master/images/antibody_design_strat_analysis_main.png?raw=true)

Antibody design analysis consists of two parts: <code>analyze_antibody_design_strategy.py</code> and <code>compare_antibody_design_strategies.py</code>

These will eventually be moved to Rosetta/tools/antibody/analysis

##Setup

Requirements include:
PyRosetta
Biopython
Compiled Rosetta
Rosetta Tools
Clustal Omega

A basic understanding of how to edit your shell profile (if using zsh, this can be edited via $HOME/.zshrc.  If Bash on linus, the profile is at $HOME/.bashrc if mac, then $HOME/.bash_profile.  Remember, no spaces before or after any equal signs.  More information on this can be found throughout the web.  [http://docs.oracle.com/cd/E19683-01/806-7612/6jgfmsvrq/index.html](this) for example.

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
The path to this repository should be added to your pthonpath in your shell profile. For example, I add this line to my zshrc file: <code>export PYTHONPATH=$PYTHONPATH:/Users/jadolfbr/Documents/modeling/rosetta/Rosetta/tools</code>

### Clustal Omega
The last thing you need to run all this is clustal Omega.  This is to create alignments between you top designs, and between your strategies.   See [http://www.clustal.org/omega/](this page) for download instructions.  The clustal binary executable should be renamed clustal_omega, and the directory in which it resides should be added to your path, for example: <code>export PATH=$PATH:/Users/jadolfbr/Documents/modeling/bin</code>

##Running Analyze Antibody Design Strategy

##Running Compare Antibody Design Strategies
