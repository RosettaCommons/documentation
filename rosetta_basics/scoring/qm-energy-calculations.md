# Quantum mechanical energy calculations in Rosetta

Back to [[Rosetta basics|Rosetta-Basics]].
Page created 16 November 2021 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

[[_TOC_]]

## Summary

Traditionally, Rosetta has used a quasi-Newtonian force field for energy calculations.  This has allowed Rosetta protocols to score a large macromolecular structure rapidly (typically in milliseconds) and repeatedly, permitting large-scale sampling of conformation and/or sequence space.  The downside, however, has been that force fields are of finite accuracy.  In late 2021, we added support for carrying out quantum mechanical energy and geometry optimization calculations in the context of a Rosetta protocol, by calling out to a third-party quantum chemistry software package.  This page summarizes how to set up and use this functionality.

## Important considerations

### Molecular system size, level of theory, and computation time

TODO

### Computer memory

TODO

### CPU usage (especially in multi-threaded or multi-process contexts)

TODO

### Disk usage

TODO

## Supported third-party quantum chemistry software packages

All Rosetta QM calculations are performed through calls to third-party quantum chemistry software packages.  These must be downloaded and installed separately, and users must have appropriate licences and privilegse to use these.  Supported packages include:

### The General Atomic and Molecular Electronic Structure System (GAMESS)

[[GAMESS|https://www.msg.chem.iastate.edu/index.html]] is a versatile quantum chemistry package written in FORTRAN, and developed by the [[Gordon group at Iowa State University|https://www.msg.chem.iastate.edu/group/members.html]].  Users may agree to the licence agreement and obtain the software from [[the GAMESS download page|https://www.msg.chem.iastate.edu/gamess/download.html]].

#### Installation and setup

To use GAMESS with Rosetta... TODO

#### Compiling GAMESS

#### Using GAMESS with Rosetta

##### Point energy calculations with GAMESS within a Rosetta protocol

A single point energy (SPE) calculation with GAMESS can be run through Rosetta directly from the command line. Depending on the user preference, user can either use an XML script or run directly from the command-line interface. Here we will quickly go through two tutorials to demonstrate how this can be done.

###### Tutorial 1 : Running SPE calculation on a known cyclic peptide (i.e. structure is obtained from the PDB or computationally)

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

##### Geometry optimization with GAMESS within a Rosetta protocol

TODO

##### Transition state identification with GAMESS within a Rosetta protocol

TODO

#### Rosetta-GAMESS bridge code organization

TODO

### Psi4

TODO

### Orca

TODO

### NWChem

TODO
