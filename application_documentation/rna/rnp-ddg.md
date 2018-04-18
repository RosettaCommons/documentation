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

