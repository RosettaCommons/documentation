#InterfaceAnalyzer

Metadata
========

Author: Steven Lewis, P. Ben Stranges, Jared Adolf-Bryfogle

Last updated June 29, 2016 by Steven Lewis. The PI is Brian Kuhlman, [bkuhlman@email.unc.edu](#) .

Code and Demo
=============

InterfaceAnalyzer has a suite of integration test/demos at rosetta/main/tests/integration/tests/InterfaceAnalyzer. The application resides at rosetta/main/source/src/apps/public/analysis/InterfaceAnalyzer.cc, and its mover at rosetta/main/source/src/protocols/anchored\_design/InterfaceAnalyzerMover.\*

The underlying [[Mover]] is documented for use (for example in [[RosettaScripts]] here: [[InterfaceAnalyzerMover]].

References
==========

No references are directly associated with this protocol. It was used with the [[AnchoredDesign application|anchored-design]] (see that app's documentation), CAPRI21 interface discrimination, and the reference below.

Stranges, P.B. and B. Kuhlman, A comparison of successful and failed protein interface designs highlights the challenges of designing buried hydrogen bonds. Protein Science, 2013. 22(1): p. 74-82.

Purpose
===========================================

This application combines a set of tools to analyze protein-protein interfaces. It calculates binding energies, buried interface surface areas, and other useful interface metrics. The bulk of the code is a Mover intended to be used at the tail end of interface modeling protocols; it considers that situation to be its primary client. This application is a front-end directly onto that Mover; it is considered a secondary purpose. This application will not work on protein-ligand interfaces.

Algorithm
=========

This code does not purposefully modify the input; instead it scores it using interface-related metrics and reports the scores.

How the interface is detected when packing the interface
========================================================

For the purposes of packing, the PackerTask is set up like so:

-   Command-line packer flags are obeyed
-   A resfile is obeyed if present on command line (-resfile) AND the InterfaceAnalyzer boolean is set to true (-use\_refile from command line, but also accessible for the Mover)
-   include\_current is activated (the current sidechain is counted as an allowable rotamer in packing)
-   No positions are allowed to design

None of these operations (except the resfile) affect the choice of what residues are at the interface.

The interface is detected via InterfaceNeighborDefinitionCalculator for two-chain interfaces. The interface is detected via InterGroupNeighborsCalculator for the multichain constructor. It serves basically the same purpose, but can detect interfaces between groups of chains. The set of residues allowed to pack from either of these calculators is logical-ANDed with the set allowed to pack from the resfile (if present); whatever both says can pack forms the interface for the purposes of repacking. Note that design is not possible; if the resfile specifies design, the design commands are ignored.

Limitations
===========

This code does not directly support ddG's of binding, but you can get that effect by running it a few times with pre-mutated structures. Any metric not listed in this file can't be directly calculated. The -fixedchains option has not been thoroughly tested beyond three chains. It will probably work but use it with care.

There is no way to output the intermediate separated chains when using the separated packing options - you are free to poke around in the code and place dump\_pdb statements if you want them.

Modes
=====

The two major modes are for two-chain and multichain interfaces. For two-chain interfaces, you need to do nothing - but defining the interface won't hurt. For interfaces involving more than two chains, you need to tell the code which chains are in which group. Define the interface either through the -fixedchain or -interface options.

Another variable that might count as a "mode" is tracer vs. PDB output. For this standalone executable, printing results to the screen (and not bothering to output "result" PDBs matching the input) is desired (and defaulted). When InterfaceAnalyzerMover is used as part of a protocol it is more common to prefer the latter.

Input Files
===========

-   [[Resfiles]] are supported for the separated-packing options

Options
=======

Describe the options your protocol uses.

-   -interface (string) - Multichain option. Which chains define the interface? example -interface LH\_A to get the interface between chain groups LH and A. Works for sub interfaces such as L\_H by ignoring any chains not specified in calculations. Not tested thoroughly beyond three chains.
-   -fixedchains (string) - Multichain option. Which chains are in the two groups to define the interface? example: -fixedchains A B to keep chains A and B together, and C separate, out of a pose that contains A, B, and C. Note a space between A and B. Analogous to -interface option. Includes all chains of the pose. Not tested thoroughly beyond three chains.

-   -compute\_packstat (bool) - activates packstat calculation; can be slow for large interfaces so it defaults to off. See the paper on RosettaHoles to find out more about this statistic (Protein Sci. 2009 Jan;18(1):229-39.).  Packstat has a significant random component; if you are interested in the score,  -packstat::oversample 100 is recommended as a companion flag; this increases runtime of packstat but reduces variance.  
-   -tracer\_data\_print (bool) - print to a tracer (true) or a scorefile (false)? Combine the true version with -out:jd2:no\_output and the false with out:file:score\_only (scorefile).
-   -pack\_input (bool) - prepack before separating chains when calculating binding energy? Useful if these are non-Rosetta inputs
-   -pack\_separated (bool) - repack the exposed interfaces when calculating binding energy? Usually a good idea.
-   -add\_regular\_scores\_to\_scorefile (bool) - performs a regular score12 score operation in addition to the InterfaceAnalyzer operations. Useful so that you don't have to combine scorefiles from score.cc or your original protocol. If you do not use this option, you may get extra fields full of zeroes in your scorefile.
-   -use\_jobname (bool) - if using tracer output, this turns the tracer name into the name of the job. If you run this code on 50 inputs, the tracer name will change to match the input, labeling each line of output with the input to which it applies. Not relevant if not using tracer output.
-   -use\_resfile (bool) - warns the protocol to watch for the existence of a resfile if it is supposed to do any packing steps. (This is normally signaled by the existence of the -resfile flag, but here the underlying InterfaceAnalyzerMover is not intended to use -resfile under normal circumstances, so a separate flag is needed. You can still pass the resfile with -resfile.) Note that resfile commands indicating design are ignored; InterfaceAnalzyer does repacking ONLY.
-   -score:weights weightsfile - weight set for the scorefunction, defaults to Score12
-   -score:patch patchfile - patch file for the scorefunction, defaults to Score12
-   -pose\_metrics::inter\_group\_neighbors\_cutoff (real) - If using the multichain constructor (the -fixedchains  or -interface option), this controls how far apart neighbors are detected - a residue is at the interface if it is within X angstroms of a residue in the other group; I think distances are determined by the nbr\_atom position, which the residue params file defines as usually c-beta. Defaults to 10 Angstroms.
-   -pose\_metrics::interface\_cutoff (real) - If detecting the interface between two chains, this sets the detection limit for neighbors. A residue is at the interface if it is within X angstroms of a residue in the other group; I think distances are determined by the nbr\_atom position, which the residue params file defines as usually c-beta.

General Rosetta/JD2 options are accepted: in:file:s, in:file:l, in:file:silent for input; -database for the database, etc.

-   It is STRONGLY suggested you use -out:file:score_only (scorefile) OR -out:jd2:no_output (bool) to suppress echoing input structures as outputs.

SASA
====

The SASA radii have changed since 3.5 to be more correct. Previously, they were using a set that was parameterized for a no-longer-in-use score function. That said, the changes are relatively minute. Rosetta now uses the radii from reduce by default (see options attached for original references to this radii set). You can now change both the radii set that is used and whether hydrogens are considered implicitly or explicitly. Also note that currently the only method is the LeGrand sasa method, which does not calculate the exact SASA. Most methods do not calculate the exact SASA for speed.

Ok, now, as for the hSASA. Polar atoms were included in the calculation before and they are not now. This should also be more correct, but it depends on what you think the hSASA should be. There is very little systematic analysis of this number. The default is to exclude the atom from hSASA if the charge on it is greater than .4 which, in terms of protein, only means to exclude carbonyl and carboxyl carbons as these are polar. Again, you can change this via an option. These general options are now in the SASA option namespace. Refer to [[this page | full-options-list#sasa]] for more.


Tips
====

-   It is STRONGLY suggested you use -out:file:score_only (scorefile) OR -out:jd2:no\_output (bool) to suppress echoing input structures as outputs.
-   Overcalculate metrics and ignore the ones you don't understand/care about, rather than trying to get just the right set calculated.
-   If using this as an application (rather than a Mover), the add\_regular\_scores\_to\_scorefile option will prevent you from getting extra zero columns in your scorefile. It's your choice depending on how you like processing your data.

Expected Outputs
================

InterfaceAnalyzer generates a ton of data about your input structure. The following are fields in the scorefile or pdb (if -tracer\_data\_print is false) that will be added by this application.

-   dSASA\_int: The solvent accessible area burried at the interface, in square Angstroms.
-   dG\_separated: The change in Rosetta energy when the interface forming chains are separated, versus when they are complexed: the binding energy. Calculated by actually separating (and optionally repacking) the chains.
-   dG\_separated/dSASAx100: Separated binding energy per unit interface area \* 100 to make units fit in score file. Scaling by dSASA controls for large interfaces having more energy. The factor of 100 is to allow standard 2.45 notation isntead of something like 2.45E-2.
-   delta\_unsatHbonds: The number of buried, unsatisfied hydrogen bonds at the interface
-   packstat: Rosetta's packing statistic score for the interface (0=bad, 1=perfect)
-   dG\_cross: Binding energy of the interface calculated with cross-interface energy terms, rather than by separating the interface. Inaccurate sometimes because of environmental dependencies in some energy terms, including hbond energy and solvation.
-   dG\_cross/dSASAx100: As above but for dGcross
-   cen\_dG: Binding energy using centroid mode and score3 score function.
-   nres\_int: Number of residues at the interface
-   per\_residue\_energy\_int: Average energy of each residue at the interface
-   side1\_score: Energy of one side of the interface
-   side2\_score: Energy of the other side of the interface
-   nres\_all: total number of residues in the entire complex
-   side1\_normalized: Average per-residue energy on one side of the interface.
-   side2\_normalized: Average per-residue energy on the other side of the interface.
-   complex\_normalized: Average energy of a residue in the entire complex
-   hbonds\_int: Total cross-interface hydrogen bonds found.   
-   hbond\_E\_fraction: Amount of interface energy (dG\_separated) accounted for by cross interface H-bonds

The following is output to either tracer or the output pdb (depending on the -tracer\_data\_print option), but (as of this writing) cannot be sent to a scorefile:

-   List of Residue, Chain, Atom missing H-bonds at the interface
-   copy and paste-able pymol-style selection for unstat hbond res. Just copy into pymol with and it will make a selection.
-   copy and paste-able pymol-style selection for interface res. Similar to above.

The following are fields that appear in the tracer output if -tracer\_data\_print is true:

-   TOTAL SASA: Total sasa of the complex (NOT the interface)
-   NUMBER OF RESIDUES: Number of residues in the complex
-   AVG RESIDUE ENERGY: Total score divided by number of residues in the complex
-   INTERFACE DELTA SASA: dSASA\_int above; interface solvent accessible surface area buried by the complex
-   CROSS-INTERFACE ENERGY SUMS: Binding energy calculated the "inaccurate", environment-insensitive way
-   SEPARATED INTERFACE ENERGY DIFFERENCE: Binding energy calculated the "accurate" way by separating the chains and optionally repacking
-   INTERFACE DELTA SASA/CROSS-INTERFACE ENERGY: Binding energy ("inaccurate") divided by SASA
-   INTERFACE DELTA SASA/SEPARATED INTERFACE ENERGY: Binding energy ("accurate") divided by SASA
-   DELTA UNSTAT HBONDS: Difference in the number of unsatisfied hydrogen bonds between the bound and unbound state
-   HBOND ENERGY: Energy due to the hydrogen bonding term
-   CROSS INTERFACE HBONDS: Total number of cross-interface hydrogen bonds scored by Rosetta.

Post Processing
===============

This application is part of your post processing for other executables; there is really no post-processing to do for itself.  

However, a typical situation for design is to select the top 10 models by interface dG of the top 10 percent of total energy.    


##See Also

* [[interface_energy]]: energy at the interface between two sets of residues
* [[Analysis applications | analysis-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs