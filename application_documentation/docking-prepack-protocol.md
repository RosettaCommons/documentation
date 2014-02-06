<!-- --- title: Docking Prepack Protocol -->Docking Prepack protocol (for Docking)

Metadata
========

Author: Robin Thottungal (raugust1@jhu.edu), Jeffrey Gray (jgray@jhu.edu)

Last edited 7/18/10. Corresponding PI Jeffrey Gray (jgray@jhu.edu).

Code and Demo
=============

-   Application source code: `        rosetta/rosetta_source/src/apps/public/docking/docking_prepack_protocol.cc       `
-   Main mover source code: `        rosetta/rosetta_source/src/protocols/docking/DockingPrepackProtocol.cc       `
-   To see demos of some different use cases see integration tests located in `        rosetta/rosetta_tests/integration/docking_prepack*       ` (docking\_prepack\_protocol).

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

Options
=======

Basic protocol options
-------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-docking:partners [P1\_P2] | Prepacking is done by separating chain P1 and chain P2 | String |
|-docking:partners LH\_A (moves chain A around fixed chains L and H) | Prepacking is done by separating  chain A and LH complex. Note that this will be usefull if you are planning to do docking between chain A and LH complex. | String |

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

