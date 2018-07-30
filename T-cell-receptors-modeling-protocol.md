# TCRmodel

# Metadata
Author: Ragul Gowthaman (ragul@umd.edu)

This document was last updated Jul 30, 2018, by Ragul Gowthaman.
 
The corresponding principal investigator is Brian Pierce (pierce@umd.edu).

[[_TOC_]]

# TCRmodel
The TCRmodel server has three main stages:

Template identification -  Template structures are identified from known TCR CDR loops and framework regions

Grafting -  Models are assembled by grafting identified template loops onto framework regions

Refinement -  Side chains and backbone of models are minimized using the fast "relax" protocol in Rosetta, and if specified by the user, CDR3 loops subjected to additional cycles of backbone refinement, using kinematic closure loop modeling (Refine: refinement, Remodel: rebuilding + refinement)

The database of template TCR structures is updated from the Protein Data Bank on a monthly basis, and currently includes several hundred crystal structures representing over 100 unique TCRs. If no template is identified among TCR structures, CDR loops are obtained from antibody crystal structures, or are modeled de novo. 

## References

Ragul Gowthaman, Brian G Pierce; TCRmodel: high resolution modeling of T cell receptors from sequence, Nucleic Acids Research, Volume 46, Issue W1, 2 July 2018, Pages W396–W401, https://doi.org/10.1093/nar/gky432

## Instructions For Running TCRmodel Protocol



## Input Files

## Output files:

## command
$rosetta_bin/Tcr -alpha <alpha-chain sequence> -beta <beta-chain sequence> -blast_identity_cutoff <90> -remodel_loop_cdr3a <False> -remodel_loop_cdr3b <False> -include_ab_templates <True> -ab_template_db_path <antibody template path>
## Analyzing the Results



##See Also

* [[Docking Applications]]: Home page for docking applications
* [[Preparing ligands]]: Notes on preparing ligands for use in Rosetta
* [[Non-protein residues]]: Notes on using non-protein molecules with Rosetta
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[RosettaScripts]]: Homepage for the RosettaScripts interface to Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files