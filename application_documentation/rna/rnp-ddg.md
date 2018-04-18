#Calculate relative binding affinities for RNA-protein complexes 

##Metadata

Author: Kalli Kappel (kappel at stanford dot edu)  
Last updated: April 2018

##Application purpose
The Rosetta-Vienna ΔΔG method is used to calculate relative binding affinities for RNA-protein complexes.  

##Code and demo
All code is located in `src/apps/public/rnp_ddg/`. A demo of the Rosetta-Vienna ΔΔG method is available in `demos/public/rnp_ddg/`.  

## The Rosetta-Vienna ddG workflow
1. Relax a starting structure
2. Calculate relative binding affinities for a list of mutants

## Required inputs
1. A starting structure in PDB format.
2. A list of sequences for which to calculate binding affinities relative to the sequence found in the starting structure. This is a text file specifying the sequences for which we want to calculate relative binding affinities. One sequence should be specified per line. These can either be the full sequence of the complex (RNA and protein), or just the RNA sequence. If the protein sequence is not specified, then no mutations to the protein will be made. 

## Running the code

#### Step 1: Set up Rosetta and Vienna code
1. Make sure that you have python (v2.7) installed.
2. Install Rosetta RNA tools. See instructions and documentation here.
3. Install the ViennaRNA package. See instructions here.

#### Step 2: Relax the starting structure

1. Set up the relaxation run with relax_starting_structure.py. For example, type: 

```
python PATH_TO_ROSETTA/main/source/src/apps/public/rnp_ddg/relax_starting_structure.py --start_struct start_structure.pdb --nstructs 100 --rosetta_prefix PATH_TO_ROSETTA/main/source/bin/
```
  
Inputs and options for relax_starting_structure.py are listed below:  
**`--start_struct`**: The starting PDB structure of your RNA-protein complex.  
`--rosetta_prefix`: The full path to your Rosetta executables (this is optional if the executables are in your PATH).  
`--sfxn`: The score function to use for relaxation. **This must be the same score function that will be used to calculate relative binding affinities in Step 3!** *Recommended*: rnp_ddg.wts.  
`--nstructs`: Number of times to perform the relaxation. *Recommended*: 100.  
