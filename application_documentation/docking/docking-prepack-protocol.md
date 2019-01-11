<!-- --- title: Docking Prepack Protocol -->Docking Prepack protocol (for Docking)

Metadata
========

Author: Robin Thottungal (raugust1@jhu.edu), Jeffrey Gray (jgray@jhu.edu)

Last edited 1/25/18. Corresponding PI Jeffrey Gray (jgray@jhu.edu).

Code and Demo
=============

An introductory tutorial on protein-protein docking can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/Protein-Protein-Docking/Protein-Protein-Docking).

-   Application source code: `        rosetta/main/source/src/apps/public/docking/docking_prepack_protocol.cc       `
-   Main mover source code: `        rosetta/main/source/src/protocols/docking/DockingPrepackProtocol.cc       `
-   To see demos of some different use cases see integration tests located in `        rosetta/main/tests/integration/tests/docking_prepack*       ` (docking\_prepack\_protocol).

To run docking\_prepack, type the following in a commandline:

```
[path to executable]/docking_prepack_protocol.[platform|linux/mac][compile|gcc/ixx]release –database [path to database] @options
```

References
==========

We recommend the following articles for further studies of RosettaDock methodology and applications:

-   Gray, J. J.; Moughon, S.; Wang, C.; Schueler-Furman, O.; Kuhlman, B.; Rohl, C. A.; Baker, D., Protein-protein docking with simultaneous optimization of rigid-body displacement and side-chain conformations. Journal of Molecular Biology 2003, 331, (1), 281-299.
-   Wang, C., Schueler-Furman, O., Baker, D. (2005). Improved side-chain modeling for protein-protein docking Protein Sci 14, 1328-1339.
-   Chaudhury, S., Berrondo, M., Weitzner, B. D., Muthu, P., Bergman, H., Gray, J. J.; (2011) Benchmarking and analysis of protein docking performance in RosettaDock v3.2. PLoSONE, Accepted for publication.

Application purpose
===========================================

Use this application to prepare a protein-protein complex for docking via standard docking protocol. In docking, the side chains are only packed at the interface. Running docking prepack protocol ensures that the side chains outside of the docking interface have a low energy conformation which is essential for scoring the decoys.

Algorithm
=========

The docking\_prepack algorithm consists of three steps:

-   Move the docking partners out of contact
-   Side chain optimization of the unbound complex
-   Bring the unbound partners back to the original orientation

Note that in a default docking\_prepack run, side chain optimization is performed by packing. Commandline options can be supplied to enable additional optimization (sc\_min, rt\_min).

Modes
-----

-   **Docking\_Prepack protocol** - additional optimization can be achived through the option system.

Input Files
===========

The only required input file is a pdb file containing two proteins with different chain IDs.

**Note:** An ensemble of input structures can be given using the following flags: `-ensemble1 [partner_1_pdb_list]` or/and `-ensemble2 [partner_2_pdb_list]`. These files contain a list of input conformations (in terms of paths to pdbs) of the ensemble. The paths should be as seen from the directory where you run the program and not the directory where `partner_1_pdb_list` is stored.  `-ensemble1` corresponds to the list of pdbs of the partner which is written at the top of the input pdb and `-ensemble2` to the partner which is at the bottom of the input pdb. Always run this before running the docking protocol for ensembles.

Options
=======

Basic protocol options
-------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-docking:partners [P1\_P2] | Prepacking is done by separating chain P1 and chain P2 | String |
|-docking:partners LH\_A (moves chain A around fixed chains L and H) | Prepacking is done by separating  chain A and LH complex. Note that this will be useful if you are planning to do docking between chain A and LH complex. | String |
|-mp:setup:spanfiles <spanfile> | Read in a spanfile for prepacking membrane proteins. Membrane protein is created and partners are translated in the membrane plane. | StringVector |


optimization Flags
------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-docking::dock\_rtmin|Does Rotomer trial with side-chain minimization (see Wang, C et al, 2005 in reference) (note: not currently implemented in docking)|Boolean|
|-docking::sc\_min|Does the side-chain global minimization over all the chi angles after packing.|Boolean|

Relevant common Rosetta Flags
-----------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-s 1abc.pdb|1abc.pdb is the pdb file with the protein-protein complex|
|-database [path to rosetta database folder]|The Rosetta database.|

Tips
====

Expected Outputs
================

One PDB file for each structure generated and a 1 scorefile for each run with scoring and name information for each structure generated.

New things since last release
=============================

Supports the modern job distributor (jd2).

* [Protein-protein Docking Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/Protein-Protein-Docking/Protein-Protein-Docking): Getting started with docking
* [[Docking Protocol]]: Main protocol for protein-protein docking
* [[Docking Applications]]: Home page for docking applications
* [[Non-protein residues]]: Notes on using non-protein molecules with Rosetta
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[RosettaScripts]]: Homepage for the RosettaScripts interface to Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files