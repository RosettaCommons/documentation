# GAMESS Point Energy Tutorial 1: Running SPE calculation on a cyclic peptide of known structure

[[Back to Quantum mechanical energy calculations in Rosetta|qm-energy-calculations]]

## GAMESS Point Energy Tutorial 1: Running SPE calculation on a cyclic peptide of known structure

A single point energy (SPE) calculation with GAMESS can be run through Rosetta directly from the command line. Depending on the user preference, user can either use an XML script or run directly from the command-line interface. Here we will quickly go through two tutorials to demonstrate how this can be done.


Say we want to know what is the SPE of the peptide 5vav (PDB ID). To do this we first download the structure from PDB. Next we need to create a file which will serve as the flags file for both Rosetta (and GAMESS through Rosetta). We are going to call this file rosetta.flags. Within this flags file we will give the following options:

-----------------------------------------------------------------------------------
-in:file:s 5vav.pdb 
-in:file:fullatom true
-score:weights gamess_qm.wts
-GAMESS_executable_version 00 
-GAMESS_path /home/bturzo/gamess
-quantum_mechanics::GAMESS::rosetta_GAMESS_bridge_temp_directory ./
-quantum_mechanics::GAMESS::clean_rosetta_GAMESS_bridge_temp_directory false
-quantum_mechanics::GAMESS::clean_GAMESS_scratch_directory false
-quantum_mechanics::GAMESS::GAMESS_threads 10
-quantum_mechanics:GAMESS:gamess_qm_energy_geo_opt false
-out:levels core.quantum_mechanics.RosettaQMDiskAccessManager_GAMESS_Output:500
-----------------------------------------------------------------------------------

In this example, 
-in:file:s is used to indicate the pdb (5vav.pdb) on which we are going to run our SPE calculation. 
-in:file:fullatom is used to enable full-atom input of PDB (Vikram is this option required?). 
-score:weights flag enables the QM score term if the weights file (gamess_qm.wts) consists the line. Additionally the weights file can be used to add further options for GAMESS (discussed later).
-quantum_mechanics::GAMESS::rosetta_GAMESS_bridge_temp_directory flag creates three files .err, .inp, and .log. In this example it will create these three files in the current directory. The .inp file consists of the input that was created for GAMESS. The .log and .err files contain the output and error (respectively) from GAMESS during the runtime.

---------------------
gamess_qm_energy 1.0
---------------------
